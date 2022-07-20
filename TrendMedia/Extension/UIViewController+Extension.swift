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
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(.init(title: "얼럿", style: .default))
        
        present(alertController, animated: true)
        
    }
    
}
