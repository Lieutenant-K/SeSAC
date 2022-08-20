//
//  PreviewImageView.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
    }

}
