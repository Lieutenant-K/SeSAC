//
//  RealmModel.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import Foundation
import RealmSwift

class Memo: Object {
    
    @Persisted var title: String
    @Persisted var subtitle: String
    @Persisted var content: String
    @Persisted var creationDate: Date
    @Persisted var isPinned: Bool
    @Persisted(primaryKey: true) var objectId: ObjectId
    

    convenience init(memoContent: MemoContent, creationDate: Date = Date(), isPinned: Bool = false) {
        self.init()
        self.title = memoContent.title
        self.subtitle = memoContent.subtitle
        self.content = memoContent.content
        self.creationDate = creationDate
        self.isPinned = isPinned

        print(#function, memoContent.title, memoContent.subtitle, memoContent.content)

    }
}

