//
//  MovieView.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/20.
//

import UIKit

import SnapKit

class MovieView: BaseView {
    
    let backgroundImageView = UIImageView(image: UIImage.randomPreviewImage)
    
    let backgroundShadowImageView = UIImageView(image: UIImage.backgroundImage)
    
    let logoLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 56, weight: .heavy)
        view.textColor = .white
        view.text = "N"
        view.textAlignment = .center
        return view
    }()
    
    
    let menus: UIStackView = {
        
        let menu1 = MenuButton(title: "TV 프로그램")
        let menu2 = MenuButton(title: "영화")
        let menu3 = MenuButton(title: "내가 찜한 콘텐츠")
        
        let view = UIStackView(arrangedSubviews: [menu1, menu2, menu3])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 16
        
        return view
    }()
    
    
    override func setSubviews() {
        
        backgroundColor = .black
        
        [backgroundImageView, backgroundShadowImageView, logoLabel, menus].forEach { addSubview($0) }
    }
    
    override func constraintSubview() {
        
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(self.snp.width).multipliedBy(1.5)
            
        }
        
        backgroundShadowImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        logoLabel.snp.makeConstraints {
            
            $0.leadingMargin.topMargin.equalTo(10)
            $0.size.equalTo(60)
            
        }
        
        menus.snp.makeConstraints { make in
            make.centerY.equalTo(logoLabel)
            make.leading.equalTo(logoLabel.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(-10)
        }
    }
    
}
