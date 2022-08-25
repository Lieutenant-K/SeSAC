//
//  StorageView.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/25.
//

import UIKit

class StorageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backupButton: UIButton = {
        
        let view = UIButton(type: .system)
        view.setTitle("데이터 백업하기", for: .normal)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        view.setTitleColor(.label, for: .normal)
        return view
    }()

    let restoreButton: UIButton = {
        
        let view = UIButton(type: .system)
        view.setTitle("데이터 복구하기", for: .normal)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        view.setTitleColor(.label, for: .normal)
        return view
    }()
    
    let tableView: UITableView = {
       let view = UITableView(frame: .zero, style: .insetGrouped)
        view.layer.cornerRadius = 12
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    func setSubviews() {
        

        [backupButton, restoreButton, tableView].forEach { addSubview($0) }
    }
    
    func setConstraints() {
        
        backupButton.snp.makeConstraints { make in
            make.trailing.leading.top.equalTo(safeAreaLayoutGuide).inset(28)
            make.height.equalTo(40)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.trailing.leading.equalTo(safeAreaLayoutGuide).inset(28)
            make.top.equalTo(backupButton.snp.bottom).offset(18)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(safeAreaLayoutGuide).inset(28)
            make.top.equalTo(restoreButton.snp.bottom).offset(18)
        }
        
    }
}
