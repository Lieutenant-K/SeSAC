//
//  PostViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

class PostViewController: UIViewController {

    let postView = PostView()
    
    override func loadView() {
        view = postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postView.pickImageButton.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        
    }
    
    @objc func touchButton() {
        
        navigationController?.pushViewController(ImageSearchViewController(), animated: true)
        
    }


}
