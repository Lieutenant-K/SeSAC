//
//  ShoppingListCell.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

class ShoppingListCell: UITableViewCell {
    
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
