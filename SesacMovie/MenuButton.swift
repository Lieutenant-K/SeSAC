//
//  MenuButton.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/20.
//

import UIKit

class MenuButton: UIButton {
    
    convenience init(title: String) {
        self.init()
        setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureButton() {
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 1
        
    }
}
