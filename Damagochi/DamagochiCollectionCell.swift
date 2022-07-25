//
//  DamagochiCollectionCell.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit

class DamagochiCollectionCell: UICollectionViewCell {
    
    static let identifier = "DamagochiCollectionCell"
    var damagochiType: DamagochiType = .none
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    
    func configurateCell(type: DamagochiType) {
        
        damagochiType = type
        
        imageView.backgroundColor = .clear
        imageView.image = type.thumbnail
        
        nameButton.setDamagochiName(title: type.name, font: .systemFont(ofSize: 13, weight: .semibold))
        
    }
    
}
