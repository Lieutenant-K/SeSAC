//
//  CardSectionCell.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/10.
//

import UIKit

class CardSectionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurateCell()
        
    }
    
    func configurateCell() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        layout.itemSize = .init(width: 200*(2.0/3.0), height: 200)
        
        contentCollectionView.collectionViewLayout = layout
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        
    }

}
