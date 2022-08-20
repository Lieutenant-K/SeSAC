//
//  MovieView.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/20.
//

import UIKit

import SnapKit

class MovieView: BaseView {
    
    let previewImageSpacing: Double = 8
    
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
    
    
    let topMenus: UIStackView = {
        
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
    
    let bottomMenus: UIStackView = {
        
        let menu1 = MenuButton(withImage: .init(named: "check"), title: "내가 찜한 콘텐츠")
        let menu2 = MenuButton(withImage: .init(named: "play_normal"))
        let menu3 = MenuButton(withImage: .init(named: "info"), title: "정보")
        
        let view = UIStackView(arrangedSubviews: [menu1, menu2, menu3])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .equalCentering
        view.spacing = 12
        
        return view
    }()
    
    let previewImages = ImageViewStack(repeat: PreviewImageView.self, count: 3, axis: .horizontal)
        
    let previewLabel: UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .white
        view.text = "미리보기"
        return view
    }()
    
    
    override func setSubviews() {
        
        backgroundColor = .black
        
        [backgroundImageView, backgroundShadowImageView, logoLabel, topMenus, bottomMenus, previewLabel, previewImages].forEach { addSubview($0) }
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
        
        topMenus.snp.makeConstraints { make in
            make.centerY.equalTo(logoLabel)
            make.leading.equalTo(logoLabel.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(-10)
        }
        
        bottomMenus.snp.makeConstraints { make in
            make.leading.bottom.equalTo(backgroundImageView)
            make.trailingMargin.lessThanOrEqualToSuperview()
//            make.height.equalTo(60)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(16)
            make.leading.equalTo(16)
        }
        
        previewImages.snp.makeConstraints { make in
            
            let spacing = previewImages.distance
            
            make.leading.trailing.equalToSuperview().inset(spacing)
            make.top.equalTo(previewLabel.snp.bottom).offset(14)
            make.bottom.lessThanOrEqualTo(safeAreaLayoutGuide)
            
            let imageCount = Double(previewImages.count)
            
            let width = imageCount > 0 ? (UIScreen.main.bounds.width - spacing*(imageCount+1))/imageCount : 0
            
            make.height.equalTo(width)
            
        }
    }
    
}
