//
//  MemorialView.swift
//  SecondProject
//
//  Created by 김윤수 on 2022/07/13.
//

import UIKit

class MemorialView: UIView {
    
    
    @IBOutlet weak var progressDayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if let view = Bundle.main.loadNibNamed("MemorialView", owner: self, options: nil)?.first as? UIView {
                    view.frame = self.bounds
                    addSubview(view)
                }
    }

}
