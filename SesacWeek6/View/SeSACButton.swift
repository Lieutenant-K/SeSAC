//
//  SeSACButton.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/09.
//

import UIKit

@IBDesignable class SeSACButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {layer.borderWidth}
        set {layer.borderWidth = newValue}
    }
    
    @IBInspectable var borderColor: UIColor {
        get { UIColor(cgColor: layer.borderColor!)}
        set { layer.borderColor = newValue.cgColor }
    }
}
