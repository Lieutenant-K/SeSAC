//
//  Model.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/02.
//

import Foundation

struct MemoContent {
    
    @DefaultMemo(text: "", defaultValue: "새로운 메모")
    var title: String
    
    @DefaultMemo(text: "", defaultValue: "추가 텍스트 없음")
    var subtitle: String
    
    var content: String = ""
    
    init(title: String = "", subtitle: String = "", content: String = "") {
        self.title = title
        self.subtitle = subtitle
        self.content = content
    }
    
}

@propertyWrapper
struct DefaultMemo {
    
    var text: String
    let defaultValue: String
    
    var wrappedValue: String {
        get { text == "" ? defaultValue : text }
        set { text = newValue }
    }
    
}
