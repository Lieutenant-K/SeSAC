//
//  WriteView.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import SnapKit

final class WriteViwe: UIView {

    let textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 20, weight: .regular)
        view.textColor = .label
        view.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        view.enablesReturnKeyAutomatically = true
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setSubviews()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        addSubview(textView)
    }
    
    private func setContraints(){
        
        textView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    
    
}
