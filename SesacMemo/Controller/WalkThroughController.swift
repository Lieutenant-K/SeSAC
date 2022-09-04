//
//  WalkThroughController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/05.
//

import UIKit
import SnapKit

class WalkThroughController: BaseViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 0
        view.textColor = .label
        view.textAlignment = .left
        view.text = """
        처음 오셨군요!
        환영합니다 :)
        
        당신만의 메모를 작성하고
        관리해보세요!
        """
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .systemOrange
        view.setTitleColor(.label, for: .normal)
        view.setTitle("확인", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.7)
//        view.backgroundColor
        setSubviews()
    }
    
    func setSubviews() {
        
        view.addSubview(containerView)
        
        containerView.addSubview(label)
        containerView.addSubview(button)
        
        label.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(18)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(18)
            make.leading.trailing.bottom.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(70)
            make.center.equalToSuperview()
            make.height.equalTo(containerView.snp.width)
        }
    }
    
    @objc func touchButton(_ sender: UIButton) {
        dismiss(animated: true)
        UserDefaults.standard.set(true, forKey: "isAgree")
    }

}
