//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setBackgroundColor() {
        
        view.backgroundColor = .orange
    }
    
    func showAlert(title: String, actionTitle: String = "확인") {
        
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.addAction(.init(title: actionTitle, style: .default))
        
        present(alertController, animated: true)
        
    }
    
    enum TransitionStyle {
        
        case present
        case presentNavigation
        case presentFullNaviagtion
        case push
        case pageSheet
        
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
        case .pageSheet:
            viewController.modalPresentationStyle = .pageSheet
            let sheet = viewController.sheetPresentationController!
            sheet.detents = [.large(), .medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.selectedDetentIdentifier = .medium
            self.present(viewController, animated: true)
        }
        
    }
    
    func saveImageToDocument(image: UIImage, fileName: String) {
        
        guard let fileURL = getImageDirectory() else { return }
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            
            do {
                try FileManager.default.createDirectory(at: fileURL, withIntermediateDirectories: false, attributes: nil)
            } catch {
                showAlert(title: "이미지 디렉토리 생성 실패")
            }
        }
        
        let url = fileURL.appendingPathComponent("\(fileName).png")
        
        let data = image.pngData()
        
        do {
            try data?.write(to: url)
        } catch let error {
            print(error)
        }
 
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        
        guard let fileURL = getImageDirectory() else { return nil }
        
        let url = fileURL.appendingPathComponent("\(fileName).png")
        
        if FileManager.default.fileExists(atPath: url.path) {
            return UIImage(contentsOfFile: url.path)
        } else {
            return .init(systemName: "xmark")
        }
 
    }
    
    func removeImageFromDocument(fileName: String) {
        
        guard let fileURL = getImageDirectory() else { return }
        
        let url = fileURL.appendingPathComponent("\(fileName).png")
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                
                try FileManager.default.removeItem(at: url)
                
            } catch let error {
                print(error)
            }
        } else {
            print("File is not Exist")
        }
        
        
        
    }
    
    func getImageDirectory() -> URL? {
        
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Image")
        
    }
    
}
