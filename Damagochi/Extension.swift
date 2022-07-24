//
//  UIButton+Extension.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit

extension UIButton {
    
    func setDamagochiName(title: String?, font: UIFont) {
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.5
        self.layer.borderColor = TintColor.foreground.cgColor
        self.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        self.setTitleColor(TintColor.foreground, for: .normal)
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
        
    }
    
}

extension UILabel {
    
    func setDamagochioLabel(text: String?, font: UIFont) {
        
        self.textColor = TintColor.foreground
        self.textAlignment = .center
        self.font = font
        self.text = text
        
        
    }
    
}

extension UINavigationController {
    
    func setDamagochiBarAppearance() {
        
        self.navigationBar.tintColor = TintColor.foreground
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.tintColor]
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.tintColor]
        appearance.shadowColor = .tintColor
        appearance.backgroundColor = TintColor.background
        
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.standardAppearance = appearance
        
    }
    
}
