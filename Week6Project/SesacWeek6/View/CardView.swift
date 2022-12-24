//
//  CardView.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/09.
//

import UIKit

/*
 Xml Interface Builder
 1. UIView Custom Class
 2. Files Owner -> 확장성이 크다
 */

class CardView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
//        print(bounds)
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
    
    
}
