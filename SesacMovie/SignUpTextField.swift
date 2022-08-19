//
//  SignUpTextField.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/19.
//

import UIKit

class SignUpTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    convenience init(placeholder:String, keyboardType: UIKeyboardType = .default) {
        self.init()
        self.attributedPlaceholder = .init(string: placeholder, attributes: [.foregroundColor: UIColor.signUpTextField])
        self.keyboardType = keyboardType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField() {
        backgroundColor = .systemGray2
        textColor = .signUpTextField
        borderStyle = .roundedRect
        textAlignment = .center
    }
}
