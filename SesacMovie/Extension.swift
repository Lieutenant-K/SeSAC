//
//  Extension.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/19.
//

import UIKit

extension UIColor {
    
    static let signUpTextField = UIColor(named: "textfieldColor")
    
}

extension UIViewController {
    
    func presentViewControllerModally<T: UIViewController>(viewController vc: T.Type) {
        
        let vc = vc.init()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        
    }
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
        
        present(alertController, animated: true)
        
    }
    
}
