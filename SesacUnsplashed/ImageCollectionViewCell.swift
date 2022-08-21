//
//  ImageCollectionViewCell.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/22.
//

import UIKit
import SnapKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCollectionViewCell"
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setSubviews() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
}
