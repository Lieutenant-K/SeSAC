//
//  SectionHeaderLabel.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/10/18.
//

import UIKit

class SectionHeaderLabel: UICollectionReusableView {
    
    let label: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 28, weight: .semibold)
        view.textColor = .label
        view.numberOfLines = 1
        view.textAlignment = .left
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints{ $0.edges.equalToSuperview().inset(8) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
