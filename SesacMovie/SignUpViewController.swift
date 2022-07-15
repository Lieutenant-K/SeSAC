//
//  SignUpViewController.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/07/06.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabel()
        setSignUpButton()
        
        idTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
        codeTextField.keyboardType = .decimalPad
        
        setTextField(textfield: idTextField, placeholder: "이메일 주소 또는 전화번호")
        setTextField(textfield: passwordTextField, placeholder: "비밀번호")
        setTextField(textfield: nickNameTextField, placeholder: "닉네임")
        setTextField(textfield: locationTextField, placeholder: "위치")
        setTextField(textfield: codeTextField, placeholder: "추천 코드 입력")
        
        additionalLabel.text = "추가 정보 입력"
        additionalLabel.textColor = .label
        
        toggle.onTintColor = .systemRed
        toggle.thumbTintColor = .white
        toggle.setOn(true, animated: true)
        
        
    }
    
    func setTitleLabel() {
        
        titleLabel.text = "JACKFLIX"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        titleLabel.textColor = .systemRed
        titleLabel.backgroundColor = view.backgroundColor
        
    }
    
    func setTextField(textfield: UITextField, placeholder: String) {
        
        textfield.placeholder = placeholder
        textfield.textAlignment = .center
        textfield.textColor = .init(named: "textfieldColor")
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor(named: "textfieldColor")])
        textfield.backgroundColor = .systemGray2
        textfield.borderStyle = .roundedRect
        
    }
    
    func setSignUpButton() {
        
        signUpButton.backgroundColor = .label
        signUpButton.layer.cornerRadius = 7
        signUpButton.clipsToBounds = true
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.systemBackground, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
    }
    
    @IBAction func touchSignUpButton(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "알림", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
        
        
        guard let text = idTextField.text, text.range(of: #"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"#,
                                                        options: .regularExpression) != nil
        else {
            alertController.title = "이메일 형식이 잘못됐습니다."
            alertController.message = "올바른 이메일인지 확인해주세요"
            present(alertController, animated: true)
            return
            
        }
        
        guard let text = passwordTextField.text, text.range(of: #"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"#, options: .regularExpression) != nil
        else {
            alertController.title = "비밀번호 형식이 잘못됐습니다."
            alertController.message = "영어 소문자, 대문자, 숫자 포함 8글자 이상"
            present(alertController, animated: true)
            return
        }
        
        guard let code = codeTextField.text, Int(code) != nil && code.count == 5 else {
            alertController.title = "코드 입력 오류"
            alertController.message = "5자리 숫자로 코드를 입력해주세요"
            present(alertController, animated: true)
            return
        }
        
        
        // 스토리보드에서 설정한 세그를 활용하는 방법
        performSegue(withIdentifier: "login", sender: self)
        
        /*
        // 전환할 Scene을 인스턴스화해서 present
        if let vc = self.storyboard?.instantiateViewController(identifier: "movie") as? ViewController {
            present(vc, animated: true)
        }
        */
        
        view.endEditing(true)
        
    }
    
    @IBAction func touchSwitch(_ sender: UISwitch) {
        
        nickNameTextField.isHidden.toggle()
        locationTextField.isHidden.toggle()
        
    }
    
    @IBAction func touchRecognizer(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    

}
