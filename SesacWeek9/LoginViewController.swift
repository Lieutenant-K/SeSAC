//
//  SignUpViewController.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/09/01.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var logginButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.nickname.bind { text in
            self.nameTextfield.text = text
        }
        
        viewModel.password.bind { text in
            self.passwordTextfield.text = text
        }
        viewModel.email.bind { text in
            self.emailTextfield.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.logginButton.isEnabled = bool
            self.logginButton.backgroundColor = bool ? .red : .lightGray
        }
        
    }
    
    @IBAction func nameTextfieldDidChanged(_ sender: UITextField) {
        
        viewModel.nickname.value = sender.text!
        viewModel.checkValidation()
        
    }
    
    @IBAction func passwordTextfieldDIdChanged(_ sender: UITextField) {
        
        viewModel.password.value = sender.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextfieldChanged(_ sender: UITextField) {
        
        viewModel.email.value = sender.text!
        viewModel.checkValidation()
        
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        
        viewModel.signIn {
            // 화면 전환
        }
    }
    
}
