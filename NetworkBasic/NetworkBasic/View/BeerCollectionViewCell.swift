//
//  BeerCollectionViewCell.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/02.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configurateCell() {
        
        self.backgroundColor = .white
//        self.imageView.backgroundColor = .black
//        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        
//        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        imageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 10
        imageView.clipsToBounds = false
        
        
    }

}
