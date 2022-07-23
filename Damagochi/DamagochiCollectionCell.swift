//
//  DamagochiCollectionCell.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit

class DamagochiCollectionCell: UICollectionViewCell {
    
    static let identifier = "DamagochiCollectionCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    
    func configurateCell() {
        
        imageView.backgroundColor = .clear
        imageView.image = .init(named: "noImage")
        
        nameButton.layer.cornerRadius = 5
        nameButton.layer.borderWidth = 1.5
        nameButton.layer.borderColor = UIColor(named: "Line")?.cgColor
        nameButton.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        nameButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        nameButton.setTitle("따끔따끔 다마고치", for: .normal)
        nameButton.setTitleColor(.init(named: "Line"), for: .normal)
        
    }
    
}
