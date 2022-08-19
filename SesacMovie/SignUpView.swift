//
//  SignUpView.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/19.
//

import UIKit
import SnapKit

class SignUpView: BaseView {

    let titleLabel: UILabel = {
        
        let view = UILabel()
        view.textColor = .red
        view.font = .systemFont(ofSize: 30, weight: .heavy)
        view.textAlignment = .center
        view.text = "JACKFLIX"
        return view
        
    }()
    
    let signUpButton: UIButton = {
       
        let view = UIButton(type: .system)
        view.setTitle("회원가입", for: .normal)
        view.setTitleColor(.systemBackground , for: .normal)
        view.backgroundColor = .label
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.titleEdgeInsets = .init(top: 16, left: 0, bottom: 16, right: 0)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        return view
        
    }()
    
    let emailTextField = SignUpTextField(placeholder: "이메일 주소 또는 전화번호", keyboardType: .emailAddress)
    let pwTextField = SignUpTextField(placeholder: "비밀번호", keyboardType: .asciiCapable)
    let nicknameTextField = SignUpTextField(placeholder: "닉네임", keyboardType: .asciiCapable)
    let locationTextField = SignUpTextField(placeholder: "위치", keyboardType: .twitter)
    let codeTextField = SignUpTextField(placeholder: "추천 코드 입력", keyboardType: .numberPad)
    
    lazy var textfields = UIStackView(arrangedSubviews: [emailTextField, pwTextField, nicknameTextField, locationTextField, codeTextField, signUpButton])
    
    
    
    override func setSubviews() {
        
        [titleLabel, textfields].forEach { addSubview($0) }
        
        setStackView()
    }
    
    override func constraintSubview() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(60)
            make.leading.greaterThanOrEqualTo(20)
            make.trailing.lessThanOrEqualTo(-20)
            make.centerX.equalToSuperview()
        }
        
        /*
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        */
        
        textfields.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(36)
            make.center.equalToSuperview()
//            make.height.equalToSuperview().dividedBy(3.0)
        }
        
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
    }
    
    func setStackView() {
        
        textfields.axis = .vertical
        textfields.distribution = .fill
        textfields.spacing = 16
        textfields.alignment = .fill
        
    }

}
