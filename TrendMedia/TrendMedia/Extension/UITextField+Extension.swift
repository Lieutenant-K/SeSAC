//
//  UITextField+Extension.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import Foundation
import UIKit

extension UITextField {
    
    func borderColor(){
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.borderStyle = .none
        
    }
}
