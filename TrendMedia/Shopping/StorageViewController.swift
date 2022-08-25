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
