//
//  MainTableViewCell.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    // MainViewController가 담당
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MainTableViewCell", #function)
        setupUI()
    }
    
    func setupUI() {
        
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "넷플릭스 인기 콘텐츠"
        label.backgroundColor = .clear
        
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = collectionViewLayout()
        
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 240, height: 150)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
