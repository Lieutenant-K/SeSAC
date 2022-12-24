//
//  CameraViewController.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/12.
//

import UIKit

import YPImagePicker
import Alamofire
import SwiftyJSON
import PhotosUI

class CameraViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var pickerView: PHPickerViewController?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        var configuration = PHPickerConfiguration()
        configuration.preferredAssetRepresentationMode = .compatible
        configuration.selection = .ordered
        configuration.selectionLimit = 0
        pickerView = PHPickerViewController(configuration: configuration)
        pickerView!.delegate = self

    }
    
    @IBAction func touchYPImagePickerButton(_ sender: UIButton) {
        
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                
                self.imageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func touchCameraButton(_ sender: UIButton) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("카메라 사용불가")
            return
        }
        
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        
        self.present(imagePicker, animated: true)
//        self.present(pickvewView, animated: true)
        
        
    }
    
    @IBAction func touchPhotoLibraryButton(_ sender: UIButton) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("카메라 사용불가")
            return
        }
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        
        self.present(imagePicker, animated: true)
        
        
    }
    
    @IBAction func touchSaveButton(_ sender: UIButton) {
        
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
    @IBAction func touchPhotoPicker(_ sender: UIButton) {
        
        
        present(pickerView!, animated: true)
        
    }
    
    @IBAction func touchAPIButton(_ sender: UIButton) {
        
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.naverID, "X-Naver-Client-Secret": APIKey.naverPW]
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.5) else { return }
        
        // 기본적으로 Content-Type을 헤더에 넣어줌
        AF.upload(multipartFormData: {
            $0.append(imageData, withName: "image")
        }, to: url, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in
                   switch response.result {
                   case .success(let value):
                       
                       let json = JSON(value)
                       print(json)
                       
                   case .failure(let error):
                       print(error)
                   }
               }
        
        
        
        
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = image
            self.dismiss(animated: true)
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true)
        print(#function)
    }
    
}

extension CameraViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        self.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let _ = itemProvider?.canLoadObject(ofClass: UIImage.self) {
            itemProvider?.loadObject(ofClass: UIImage.self)  { image, error in
                
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        
    }
}
