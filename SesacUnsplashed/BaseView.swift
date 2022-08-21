//
//  BaseView.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setSubviews() {}
    
    func setConstraints() {}
}
