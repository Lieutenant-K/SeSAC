//
//  BaseView.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/19.
//

import UIKit

class BaseView: UIView {

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        constraintSubview()
    }
    
    func setSubviews() {}
    
    func constraintSubview() {}
}
