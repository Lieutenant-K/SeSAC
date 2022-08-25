//
//  StorageViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/25.
//

import UIKit

import Zip
import JGProgressHUD

class StorageViewController: UIViewController {
    
    // MARK: - Property
    
    var files = [URL]()
    
    lazy var storageView: StorageView = {
        let view = StorageView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()
    
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = storageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageView.backupButton.addTarget(self, action: #selector(touchBackupButton), for: .touchUpInside)
        
        storageView.restoreButton.addTarget(self, action: #selector(touchRestoreButton), for: .touchUpInside)
        
//        fetchDocumentZipFile()
        
        fetchFilesInDocument()
        
    }
    
    // MARK: - Action Method
    
    @objc func touchBackupButton() {
        
        zipFiles(targetToZip: [.realmFile, .imageDirectory])
        
        fetchFilesInDocument()
        
    }
    
    @objc func touchRestoreButton() {
        
        let vc = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        
        vc.delegate = self
        
        present(vc, animated: true)
        
    }
    
    // MARK: - Method
    
    func fetchFilesInDocument() {
        
        guard let documentURL = getDocumentDirectory() else {
            showAlert(title: "파일이 저장된 경로를 찾을 수 없습니다")
            return
        }
        
        do {

            let urls = try FileManager.default.contentsOfDirectory(at: documentURL, includingPropertiesForKeys: nil)
            
            files = urls.filter { url in url.pathExtension == "zip" }
            
            storageView.tableView.reloadSections([0], with: .automatic)
            
        } catch {
            
        }
    }
    
    func showRestoreAlert(fileURL: URL) {
        
        let alert = UIAlertController(title: fileURL.lastPathComponent, message: "이 파일로 복구하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "예", style: .destructive) { _ in
            self.unzipFile(targetToUnzip: fileURL)
        }
        
        let cancle = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancle)
        
        present(alert, animated: true)
        
    }
    
}

// MARK: - UITableView Delegate, Datasource

extension StorageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
        cell.configureCellWithURLResources(url: files[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fileURL = files[indexPath.row]
        

        
        showRestoreAlert(fileURL: fileURL)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIDocumentPicker Delegate

extension StorageViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        print(#function, urls)
        
        guard let src = urls.first else {
            showAlert(title: "선택한 파일의 경로를 찾을 수 없습니다.")
            return
        }
        guard let documentURL = getDocumentDirectory() else {
            showAlert(title: "저장할 디렉토리의 경로를 찾을 수 없습니다.")
            return
        }
        
        let dst = documentURL.appendingPathComponent(src.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: dst.path) {
            showAlert(title: "같은 이름의 파일이 존재합니다.", message: "삭제 후 다시 시도해주세요")
            return
        } else {
            do {
                try FileManager.default.copyItem(at: src, to: dst)
                showAlert(title: "파일 가져오기 성공", message: "백업 파일을 선택해주세요")
                fetchFilesInDocument()
            }  catch {
                showAlert(title: "파일 가져오기 실패")
            }
        }
        
    }
    
}
