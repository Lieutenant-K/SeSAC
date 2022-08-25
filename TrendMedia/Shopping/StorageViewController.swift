//
//  StorageViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/25.
//

import UIKit

import Zip

class StorageViewController: UIViewController {

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
        
//        fetchDocumentZipFile()
        
    }
    
    @objc func touchBackupButton() {
        
        zipFiles(targetToZip: [.realmFile, .imageDirectory])
        
        /*
        var paths = [URL]()
        
        guard let documentURL = getDocumentDirectory() else { return }
        
        let realmFileURL = documentURL.appendingPathComponet(pathComponent: .realmFile)
        let imageURL = documentURL.appendingPathComponet(pathComponent: .imageDirectory)
        
        if FileManager.default.fileExists(atPath: realmFileURL.path) {
            paths.append(realmFileURL)
        }
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            paths.append(imageURL)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let fileName = dateFormatter.string(from: Date())
        
        let destinationPath = documentURL.appendingPathComponet(pathComponent: .zipFilePath(fileName: fileName))
        
        do {
            try Zip.zipFiles(paths: paths, zipFilePath: destinationPath, password: nil) { progress in
                print(progress)
                let vc = UIActivityViewController(activityItems: [destinationPath], applicationActivities: nil)
                self.present(vc,animated: true)
            }
        } catch {
            showAlert(title: "파일 압축 실패")
        }
        */
    }
    
    @objc func touchRestoreButton() {
        
      
        
    }
    
}

extension StorageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
