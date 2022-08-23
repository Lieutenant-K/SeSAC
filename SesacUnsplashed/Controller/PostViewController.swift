//
//  PostViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit
import PhotosUI

import RealmSwift

class PostViewController: UIViewController {

    let postView = PostView()
    
    let localRealm = try! Realm() // Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    lazy var imagePicker: UIImagePickerController = {
       
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        return vc
        
    }()
    
    lazy var pickerViewController: PHPickerViewController = {
       
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.selection = .default
        config.preferredAssetRepresentationMode = .automatic
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        
        return vc
        
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageSelectButtonMenu()
        
        postView.gestureRecognizer.addTarget(self, action: #selector(tapGestureRegognizer))
        
        configureBarButtonItem()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveImageURLNotification(_:)), name: .sendImageURLNotification, object: nil)
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
    }
    
    // MARK: - Method
    
    func setImageSelectButtonMenu() {
        
        let menuItems = [
            UIAction(title: "이미지 검색", image: .init(systemName: "magnifyingglass"), handler: { _ in
                
                self.navigationController?.pushViewController(ImageSearchViewController(), animated: true)
                
            })
            ,UIAction(title: "앨범", image: .init(systemName: "photo"), handler: { _ in
                
                self.present(self.pickerViewController, animated: true)
                
            })
            ,UIAction(title: "사진 촬영", image: .init(systemName: "camera"), handler: { _ in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    
                    self.present(self.imagePicker, animated: true)
                }
                
                
            })
        ]
        
        postView.pickImageButton.menu = UIMenu(title: "어디서 이미지를 불러올까요?", options: .displayInline, children: menuItems)
        
    }
    
    func configureBarButtonItem() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .init(systemName: "xmark"), style: .plain, target: self, action: #selector(touchDismissButton))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "checkmark"), style: .plain, target: self, action: #selector(touchPostingButton))
        
    }
    
    // MARK: - Action Method
    
    @objc func touchImageSelectButton() {
        
        navigationController?.pushViewController(ImageSearchViewController(), animated: true)
        
    }
    
    @objc func touchDismissButton() {
        
        self.dismiss(animated: true)
        
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
            
            self.dismiss(animated: true)
//            navigationController?.dismiss(animated: true)
//            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func receiveImageURLNotification(_ noti: Notification) {
        
        guard let imageURL = noti.userInfo?["imageURL"] as? String else { return }
        
        postView.imageView.setImage(url: imageURL)
        
    }


}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        self.postView.imageView.image = image
        
        self.dismiss(animated: true)
        
    }
    
}

extension PostViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        self.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let _ = itemProvider?.canLoadObject(ofClass: UIImage.self) {
            itemProvider?.loadObject(ofClass: UIImage.self)  { image, error in
                
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.postView.imageView.image = image
                    }
                }
            }
        }
        
    }
}
