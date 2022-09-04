//
//  ListCell.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import SnapKit

final class ListCell: UITableViewCell {
    
    let mainLabel: UILabel = {
       let view = UILabel()
        view.textColor = .label
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 1
        return view
    }()
    
    let subLabel: UILabel = {
       let view = UILabel()
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.numberOfLines = 1
        return view
    }()
    
    private func setSubviews() {
        
        [mainLabel, subLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).inset(16)
            make.trailing.equalTo(contentView).offset(-8)
        }
        
        subLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.bottom.equalTo(contentView).inset(8)
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
