//
//  CreditCell.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/04.
//

import UIKit

import Kingfisher

class CreditCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView! {
        didSet{
            profileImageView.layer.cornerRadius = 10
        }
        
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    func configurateCell(title: String, subTitle: String, profilePath: String) {
        
        let url = EndPoint.image(.profile(.w185), profilePath).url
        
        titleLabel.text = title
        subLabel.text = subTitle
        profileImageView.kf.setImage(with: URL(string: url))
        
    }
    
}
