//
//  CardCell.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/10.
//

import UIKit

import Kingfisher

class CardCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        cardView.cardImageView.layer.cornerRadius = 10
        cardView.cardImageView.backgroundColor = .lightGray
        
    }
    
    func configurateCell(info: MovieInfo) {
        
        let url = URL(string: EndPoint.image(.poster(.w185), info.postPath).url)
        
        self.cardView.cardImageView.kf.setImage(with: url)
        
    }

}
