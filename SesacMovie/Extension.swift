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
    
}
