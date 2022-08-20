//
//  ImageViewStack.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

class ImageViewStack: UIStackView {
    
    let distance: CGFloat = 12
    
    var count: Int {
        arrangedSubviews.count
    }
    
    init<T: UIImageView>(repeat type: T.Type, count: Int, axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        
        [Int](0...count-1).forEach { _ in addArrangedSubview(type.init())}
        self.axis = axis
        alignment = .fill
        distribution = .fillEqually
        spacing = distance
        
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    
}
