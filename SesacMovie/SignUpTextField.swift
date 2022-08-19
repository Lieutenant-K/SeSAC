//
//  SignUpTextField.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/19.
//

import UIKit

class SignUpTextField: UITextField {
    
    var type: TextFieldContentType = .none {
        didSet {
            placeholder = type.placeholder
            keyboardType = type.keyboardType
            isSecureTextEntry = type == .password
        }
    }
    
    override var placeholder: String? {
        get { attributedPlaceholder?.string }
        set
        {
            attributedPlaceholder = .init(string: newValue ?? "", attributes: [.foregroundColor: UIColor.signUpTextField])
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    convenience init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        self.init()
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
    
    convenience init(type: TextFieldContentType) {
        self.init(placeholder: type.placeholder, keyboardType: type.keyboardType)
        self.type = type
        isSecureTextEntry = type == .password
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
    
    func checkValidation() -> Bool {
        
        guard let regularEx = type.regularEx else { return true }
        
        guard let text = self.text, text.range(of: regularEx, options: .regularExpression) != nil
        else {
            
            return false
        }
        
        return true
        
    }
}
