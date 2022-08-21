//
//  PostView.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

import SnapKit

class PostView: BaseView {
    
    let imageView:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
        
    }()
    
    let textfield1: UITextField = {
        
        let view = UITextField()
        view.borderStyle = .bezel
        view.placeholder = "뭘 쓰는지 모르겠다~"
        return view
        
    }()
    
    let textfield2: UITextField = {
        
        let view = UITextField()
        view.borderStyle = .bezel
        view.placeholder = "뭘 쓰는지 모르겠다~"
        return view
        
    }()
    
    let textView = UITextView()
    
    let pickImageButton: UIButton = {
        
        let view = UIButton(type: .system)
        view.setTitle("선택", for: .normal)
        view.setTitleColor(.systemBackground, for: .normal)
        return view
    }()
    
    override func setSubviews() {
        
        backgroundColor = .systemBackground
        
        [imageView, textfield1, textfield2, textView, pickImageButton].forEach { addSubview($0) }
        
    }

    override func setConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.leadingMargin.trailingMargin.topMargin.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(imageView.snp.width)
        }
        
        pickImageButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.trailingMargin.bottomMargin.equalTo(imageView).inset(20)
        }
        
        textfield1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        textfield2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(textfield1.snp.bottom).offset(20)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.top.equalTo(textfield2.snp.bottom).offset(20)
            
        }
        
        
    }
}
