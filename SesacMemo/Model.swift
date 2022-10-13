//
//  Model.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/02.
//

import UIKit
import RealmSwift

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

struct MemoCollection {
    
    var pinnedMemos: Results<Memo>!
    var memos: Results<Memo>!
    
    var numberOfSection: Int {
        return (pinnedMemos.count > 0 ? 1 : 0) + 1
    }
    
    var totalMemoCount: Int {
        pinnedMemos.count + memos.count
    }
    
    mutating func changeValue(result: Results<Memo>) {
        pinnedMemos = result.where { $0.isPinned == true }
        memos = result.where { $0.isPinned == false }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        numberOfSection > 1 ? [pinnedMemos, memos][section].count : memos.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Memo {
        numberOfSection > 1 ? [pinnedMemos, memos][indexPath.section][indexPath.row] : memos[indexPath.row]
    }
    
    func sectionTitle(section: Int) -> String {
        numberOfSection > 1 ? ["고정된 메모", "메모"][section] : "메모"
    }
}
