//
//  PostViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit
import PhotosUI

import RealmSwift

protocol ImageSendable {
    
    func sendImageData(image: UIImage?)
    
}

class PostViewController: UIViewController {

    let postView = PostView()
    
    let viewModel = PostViewModel()
    
    let repository = UserDiaryRepository() // Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
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
        
        postView.gestureRecognizer.addTarget(self, action: #selector(tapGestureRegognizer))
        
        postView.textfield1.addTarget(self, action: #selector(titleDidChanged), for: .editingChanged)
        
        postView.textView.delegate = self
        
        setImageSelectButtonMenu()
        
        configureBarButtonItem()
        
        binding()
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveImageURLNotification(_:)), name: .sendImageURLNotification, object: nil)
        
        print("Realm is located at:", repository.localRealm.configuration.fileURL!)
        
    }
    
    // MARK: - Method
    
    func binding() {
        
        viewModel.title.bind { [unowned self] in
            postView.textfield1.text = viewModel.title.value
        }
        
        viewModel.subtitle.bind { [unowned self] in
            postView.textfield2.text = viewModel.subtitle.value
        }
        
        viewModel.content.bind { [unowned self] in
            postView.textView.text = viewModel.content.value
        }
        
    }
    
    func setImageSelectButtonMenu() {
        
        let menuItems = [
            UIAction(title: "이미지 검색", image: .init(systemName: "magnifyingglass")) { [self] _ in
                
                let vc = ImageSearchViewController()
                vc.delegate = self
                
                transition(vc, transitionStyle: .push)
                
            }
            ,UIAction(title: "앨범", image: .init(systemName: "photo")) { [self] _ in
                
                transition(pickerViewController)
                
            }
            ,UIAction(title: "사진 촬영", image: .init(systemName: "camera")) { [self] _ in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    
                    transition(imagePicker)
                }
            }
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
        
        let title = viewModel.title.value
        
        let content = viewModel.content.value
        
        let task = UserDiary(title: title, content: content, diaryDate: Date(), postingDate: Date(), photo: nil) // => Record 추가
        
        do {
            try repository.addItem(item: task)
            
            if let image = postView.imageView.image {
                saveImageToDocument(fileName: "\(task.objectId).jpg", image: image)
            }
            
            self.dismiss(animated: true)

            
        } catch {
            showAlert(title: "다이어리 작성 실패")
        }
        
    }
    
    @objc func titleDidChanged(_ sender: UITextField) {
        
        viewModel.inputTitle(text: sender.text!)
        
    }
    
    
    
    @objc func receiveImageURLNotification(_ noti: Notification) {
        
        guard let imageURL = noti.userInfo?["imageURL"] as? String else { return }
        
        postView.imageView.setImage(url: imageURL)
        
    }


}

// MARK: - UIImagePickerControllerDelegate

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        self.postView.imageView.image = image
        
        self.dismiss(animated: true)
        
    }
    
}

// MARK: - PHPickverViewController

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

extension PostViewController: ImageSendable {
    
    func sendImageData(image: UIImage?) {
        postView.imageView.image = image
    }
    
    
}

extension PostViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.content.value = textView.text
    }
    
}
