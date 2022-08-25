//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import Foundation
import UIKit
import Zip
import JGProgressHUD

extension UIViewController {
    
    func setBackgroundColor() {
        
        view.backgroundColor = .orange
    }
    
    func showAlert(title: String, message: String = "", actionTitle: String = "확인") {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
            sheet.preferredCornerRadius = 20
            self.present(viewController, animated: true)
        }
        
    }
    
    
    
    func saveImageToDocument(image: UIImage, fileName: String) {
        
        guard let imageURL = getDocumentDirectory()?.appendingPathComponet(pathComponent: .imageDirectory) else { return }
        
        if !FileManager.default.fileExists(atPath: imageURL.path) {
            
            do {
                try FileManager.default.createDirectory(at: imageURL, withIntermediateDirectories: false, attributes: nil)
            } catch {
                showAlert(title: "이미지 디렉토리 생성 실패")
            }
        }
        
        let url = imageURL.appendingPathComponent("\(fileName).png")
        
        let data = image.pngData()
        
        do {
            try data?.write(to: url)
        } catch let error {
            print(error)
        }
 
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        
        guard let imageURL = getDocumentDirectory()?.appendingPathComponet(pathComponent: .imageDirectory) else { return nil }
        
        let url = imageURL.appendingPathComponent("\(fileName).png")
        
        if FileManager.default.fileExists(atPath: url.path) {
            return UIImage(contentsOfFile: url.path)
        } else {
            return .init(systemName: "xmark")
        }
 
    }
    
    func removeImageFromDocument(fileName: String) {
        
        guard let imageURL = getDocumentDirectory()?.appendingPathComponet(pathComponent: .imageDirectory) else { return }
        
        let url = imageURL.appendingPathComponent("\(fileName).png")
        
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
    
    func getDocumentDirectory() -> URL? {
        
        let baseDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        return baseDirectory
        
        /*
        if let path = lastPath.path {
            return baseDirectory?.appendingPathComponent(path)
        } else {
            return baseDirectory
        }*/
        
    }
    
    static let  progressHUD = JGProgressHUD(style: .dark)
    
    static func setProgressHUD(mainText: String, detailText: String? = nil, position: JGProgressHUDPosition = .center, indicator: JGProgressHUDIndicatorView.Type) {
        
        progressHUD.textLabel.text = mainText
        progressHUD.position = position
        progressHUD.detailTextLabel.text = detailText
        progressHUD.indicatorView = indicator.init()
        
    }
    
    
    func zipFiles(targetToZip paths: [DesignatedPath]) {
        
        guard let documentURL = getDocumentDirectory() else { return }
        
        let paths = paths.map{ documentURL.appendingPathComponet(pathComponent: $0) }.filter { FileManager.default.fileExists(atPath: $0.path) }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let fileName = dateFormatter.string(from: Date())
        
        let destinationPath = documentURL.appendingPathComponet(pathComponent: .zipFilePath(fileName: fileName))
        
        do {
            
            Self.setProgressHUD(mainText: "파일 백업 중...", detailText: nil, position: .topCenter, indicator: JGProgressHUDIndeterminateIndicatorView.self)
            
            Self.progressHUD.show(in: view, animated: true)
            
            // 모달 dragToDown 제스처 막기
            self.isModalInPresentation = true
            
            try Zip.zipFiles(paths: paths, zipFilePath: destinationPath, password: nil) { progress in
                
                Self.progressHUD.indicatorView?.setProgress(Float(progress), animated: true)
                print(progress)
                
            }
//            print("압축 완료 시점")
            Self.progressHUD.indicatorView = JGProgressHUDSuccessIndicatorView()
            Self.progressHUD.textLabel.text = "백업 완료!"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                
                let vc = UIActivityViewController(activityItems: [destinationPath], applicationActivities: nil)
                
                Self.progressHUD.dismiss(animated: true)
                
                self.present(vc,animated: true)
                
                self.isModalInPresentation = false
                
            }
            
        } catch {
            
            Self.progressHUD.indicatorView = JGProgressHUDErrorIndicatorView()
            Self.progressHUD.textLabel.text = "백업 실패"
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                
                Self.progressHUD.dismiss(animated: true)
                
                self.isModalInPresentation = false
            }
            
        }
    }
    
    func unzipFile(targetToUnzip path: URL) {
        
        guard let documentURL = getDocumentDirectory() else {
            showAlert(title: "복구할 파일 디렉토리가 존재하지 않습니다.")
            return
        }
        
        if FileManager.default.fileExists(atPath: path.path) {
            
            do {
                
                Self.setProgressHUD(mainText: "파일 복구 중...", position: .topCenter, indicator: JGProgressHUDIndeterminateIndicatorView.self)
                
                Self.progressHUD.show(in: view, animated: true)
                
                // 모달 dragToDown 제스처 막기
                self.isModalInPresentation = true
                
                try Zip.unzipFile(path, destination: documentURL, overwrite: true, password: nil, progress: { progress in
                    
                    Self.progressHUD.indicatorView?.setProgress(Float(progress), animated: true)
                    
                    print(progress)
                    
                }, fileOutputHandler: { unzippedFile in
                    print(#function, unzippedFile)
                    
                    
                })
                
                Self.progressHUD.indicatorView = JGProgressHUDSuccessIndicatorView()
                Self.progressHUD.textLabel.text = "복구 완료!"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    
                    Self.progressHUD.dismiss(animated: true)
                    
                    self.isModalInPresentation = false
                    
                }
                
            } catch {
                
                Self.progressHUD.indicatorView = JGProgressHUDErrorIndicatorView()
                Self.progressHUD.textLabel.text = "복구 실패"
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    
                    Self.progressHUD.dismiss(animated: true)
                    
                    self.isModalInPresentation = false
                }
                
            }
            
        } else {
            showAlert(title: "파일이 존재하지 않습니다.")
            return
        }
        
    }
    
}

enum DesignatedPath {
    
    case imageDirectory
    case realmFile
    case zipFilePath(fileName: String)
//    case none
    
    var path: String {
        switch self {
        case .imageDirectory:
            return "Image"
        case .realmFile:
            return "default.realm"
        case .zipFilePath(let fileName):
            return "\(fileName).zip"
//        case .none:
//            return nil
        }
    }
}

extension URL {
    
    func appendingPathComponet(pathComponent: DesignatedPath) -> URL {
        
        return appendingPathComponent(pathComponent.path)
    }
}

