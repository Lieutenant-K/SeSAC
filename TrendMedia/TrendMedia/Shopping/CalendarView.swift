//
//  CalendarView.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/28.
//

import UIKit

import FSCalendar
import SnapKit

class CalendarView: UIView {
    
    let calendar: FSCalendar = {
       let view = FSCalendar()
       return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        
        addSubview(calendar)
        
    }
    
    func setConstraints(){
        
        calendar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
