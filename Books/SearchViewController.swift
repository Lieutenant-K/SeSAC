//
//  SearchViewController.swift
//  Books
//
//  Created by 김윤수 on 2022/07/21.
//

import UIKit

class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = .init(image: .init(systemName: "xmark"), style: .plain, target: self, action: #selector(touchCloseButton(_:)))
        
    }
    
    @objc func touchCloseButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true)
        
    }

}
