//
//  SearchImageCell.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/03.
//

import UIKit

import Kingfisher

class SearchImageCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func configurateContent(data: ImageSearchData) {
        
        self.titleLabel.text = data.title
//        print(data.link)
        self.imageView.kf.setImage(with: URL(string: data.link))
        
    }
}
