//
//  StorageViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/24.
//

import UIKit

import Zip

class StorageViewController: UIViewController {
    
    var files:[String] = []
    
    lazy var storageView: StorageView = {
        let view = StorageView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()
    
    override func loadView() {
        view = storageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageView.backupButton.addTarget(self, action: #selector(touchBackupButton), for: .touchUpInside)
        
        storageView.restoreButton.addTarget(self, action: #selector(touchRestoreButton), for: .touchUpInside)
        
        files = fetchDocumentZipFile()
        
        storageView.tableView.reloadData()
        
    }
    
    @objc func touchBackupButton() {
        
        // URL 담을 배열 생성
        var urlPaths = [URL]()
        
        // Document 디렉토리의 경로 찾기
        guard let path = documentDirectoryPath() else {
            showAlert(title: "백업 폴더를 찾을 수 없습니다.")
            return
        }
        
        // Document 디렉토리의 DB파일(realm 파일) 경로 찾기
        let realmFile = path.appendingPathComponent("default.realm")
        
        // 경로에 파일이 있는지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlert(title: "백업할 파일을 찾을 수 없습니다.")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACDiary_1")
            print("Acheive Location: \(zipFilePath)")
            showActivityViewController(fileURL: zipFilePath)
            
            
        } catch {
            showAlert(title: "압축을 실패했습니다")
        }
        
        
    }
    
    @objc func touchRestoreButton() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true)
        
    }
    
}

extension StorageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = files[indexPath.row]
        
        return cell
    }
    
    
}

extension StorageViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        // 파일 앱에서 선택된 파일의 경로
        guard let selectedFileURL = urls.first else {
            showAlert(title: "선택한 파일 경로가 존재하지 않습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlert(title: "복구할 디렉토리가 경로가 존재하지 않습니다.")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
//            let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
            
            do {
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("\(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print(unzippedFile)
                    self.showAlert(title: "복구가 완료됐습니다")
                })
            } catch {
                showAlert(title: "압축 해제에 실패했습니다")
            }
            
        } else {
            
            do {
                // 파일 앱의 zip 파일을 앱의 Document 디렉토리에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("\(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print(unzippedFile)
                    self.showAlert(title: "복구가 완료됐습니다")
                })
                
            } catch {
                showAlert(title: "압축 해제에 실패했습니다")
            }
            
        }
        
    }
}
