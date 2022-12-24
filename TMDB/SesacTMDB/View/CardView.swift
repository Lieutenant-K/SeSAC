//
//  CardView.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/10.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
    
        view.frame = self.bounds
        
        self.addSubview(view)

        
    }
    

}
