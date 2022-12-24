//
//  ItemDetailViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/24.
//

import UIKit
import PhotosUI
import SnapKit
import RealmSwift
import Toast

class ItemDetailViewController: UIViewController {
    
    let item: ShoppingItem

    lazy var imageView: UIImageView = {
        
        let view = UIImageView()
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.contentMode = .scaleAspectFill
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentPickerViewController)))
        view.isUserInteractionEnabled = true
        view.image = ImageFileManager.shared.loadImageFromDocument(fileName: item.objectId.stringValue)
        return view
    }()
    
    lazy var imagePickerController: PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        
        let view = PHPickerViewController(configuration: config)
        view.delegate = self
        
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(28)

        }
        
        title = item.itemName
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "checkmark"), style: .plain, target: self, action: #selector(touchCompleteButton))
        
    }
    
    @objc func presentPickerViewController() {
        
        print(#function)
        
        present(imagePickerController, animated: true)
        
    }
    
    @objc func touchCompleteButton() {
        
        print(#function)
        
        guard let image = imageView.image else {
            view.makeToast("이미지를 선택해주세요", position: .bottom)
            return
            
        }
        
        ImageFileManager.shared.saveImageToDocument(image: image, fileName: item.objectId.stringValue)
        
        self.dismiss(animated: true)
        
    }
    
    init(item: ShoppingItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension ItemDetailViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        self.dismiss(animated: true)
        
        if let _ = results.first?.itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            results.first?.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
}
