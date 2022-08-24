//
//  Extension.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        
        case present
        case presentNavigation
        case presentFullNaviagtion
        case push
        
    }

    func transition<T: UIViewController> (_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .presentFullNaviagtion:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        // 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return .init(systemName: "checkmark")
        }
            
    }
    
    func removeImageFromDocument(fileName: String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            
            try FileManager.default.removeItem(at: fileURL)
            
        } catch let error {
            print(error)
        }
        
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 이미지를 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
        
    }
    
}


