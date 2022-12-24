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
    
    let emailTextField = SignUpTextField(type: .email)
    let pwTextField = SignUpTextField(type: .password)
    let nicknameTextField = SignUpTextField(type: .nickname)
    let locationTextField = SignUpTextField(placeholder: "위치", keyboardType: .twitter)
    let codeTextField = SignUpTextField(type: .code)
    
    lazy var textfields: UIStackView = {
        
        let view =
        UIStackView(arrangedSubviews: [emailTextField, pwTextField, nicknameTextField, locationTextField, codeTextField, signUpButton])
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 16
        view.alignment = .fill
        return view
        
    }()
    
    
    let additionalLabel: UILabel = {
       let view = UILabel()
        view.text = "추가 정보 입력"
        view.textColor = .label
        return view
    }()
    
    let additionalLabelSwitch: UISwitch = {
        let view = UISwitch()
        view.onTintColor = .red
        view.isOn = true
        return view
    }()
    
    
    override func setSubviews() {
        
        self.backgroundColor = .systemBackground
        
        [titleLabel, textfields, additionalLabel, additionalLabelSwitch].forEach { addSubview($0) }
        
    }
    
    override func constraintSubview() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(60)
            make.leading.greaterThanOrEqualTo(20)
            make.trailing.lessThanOrEqualTo(-20)
            make.centerX.equalToSuperview()
        }
        
        
        textfields.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(36)
            make.center.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        additionalLabelSwitch.snp.makeConstraints { make in
            make.top.equalTo(textfields.snp.bottom).offset(16)
            make.trailing.equalTo(textfields)
        }
        
        additionalLabel.snp.makeConstraints { make in
            make.top.equalTo(textfields.snp.bottom).offset(16)
            make.leading.equalTo(textfields)
        }
    }

}
