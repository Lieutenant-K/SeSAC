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
    
    override var isSelected: Bool {
        didSet {
            imageView.alpha = isSelected ? 0.5 : 1.0
        }
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
//        view.backgroundColor = .blue
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setSubviews() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
}
