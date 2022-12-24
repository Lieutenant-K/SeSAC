//
//  CodeBaseSignUpViewController.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/19.
//

import UIKit

class CodeBaseSignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    
    override func loadView() {
        
        self.view = signUpView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.signUpButton.addTarget(self, action: #selector(touchSignUpButton(_:)), for: .touchUpInside)
        
        signUpView.additionalLabelSwitch.addTarget(self, action: #selector(toggleSwitch(_:)), for: .valueChanged)
        
    }
    
    @objc func touchSignUpButton(_ sender: UIButton) {
        
        for textfield in signUpView.textfields.arrangedSubviews {
            if let textfield = textfield as? SignUpTextField {
                if !textfield.checkValidation() {
                    let title = textfield.type.validationCheckingMessage.0
                    let message = textfield.type.validationCheckingMessage.1
                    showAlert(title: title, message: message)
                    return
                }
            }
        }
        
        presentViewControllerModally(viewController: CodeBaseMovieViewController.self)
        
    }
    
    @objc func toggleSwitch(_ sender: UISwitch) {
        
        [signUpView.nicknameTextField, signUpView.locationTextField].forEach {
            $0.isHidden = !sender.isOn
        }
    }


}
