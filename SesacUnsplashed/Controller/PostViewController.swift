//
//  PostViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

import RealmSwift

class PostViewController: UIViewController {

    let postView = PostView()
    let localRealm = try! Realm() // Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postView.gestureRecognizer.addTarget(self, action: #selector(tapGestureRegognizer))
        
        postView.pickImageButton.addTarget(self, action: #selector(touchImageSelectButton), for: .touchUpInside)
        
        postView.postButton.addTarget(self, action: #selector(touchPostingButton), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveImageURLNotification(_:)), name: .sendImageURLNotification, object: nil)
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
    }
    
    // MARK: - Action Method
    
    @objc func touchImageSelectButton() {
        
        navigationController?.pushViewController(ImageSearchViewController(), animated: true)
        
    }
    
    @objc func tapGestureRegognizer() {
        
        postView.endEditing(true)
        
    }
    
    @objc func touchPostingButton() {
        
        guard let title = postView.textfield1.text, let content = postView.textView.text else { return }
        
        let task = UserDiary(title: title, content: content, diaryDate: Date(), postingDate: Date(), photo: nil) // => Record 추가
        
        try! localRealm.write {
            localRealm.add(task) // create
            print("Realm Succed")
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func receiveImageURLNotification(_ noti: Notification) {
        
        guard let imageURL = noti.userInfo?["imageURL"] as? String else { return }
        
        postView.imageView.setImage(url: imageURL)
        
    }


}
