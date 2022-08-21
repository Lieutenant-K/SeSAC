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
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveImageURLNotification(_:)), name: .sendImageURLNotification, object: nil)
        
    }
    
    @objc func touchButton() {
        
        navigationController?.pushViewController(ImageSearchViewController(), animated: true)
        
    }
    
    @objc func receiveImageURLNotification(_ noti: Notification) {
        
        guard let imageURL = noti.userInfo?["imageURL"] as? String else { return }
        
        postView.imageView.setImage(url: imageURL)
        
    }


}
