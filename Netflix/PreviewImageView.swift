//
//  PreviewImageView.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

import SnapKit

class PreviewImageView: UIImageView {
    
    init() {
        super.init(image: UIImage.randomPreviewImage)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureImageView() {
        
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        
        
    }
    
    override func updateConstraints() {
        
        snp.makeConstraints { $0.height.equalTo(self.snp.width) }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
    }

}
