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
    @Persisted var content: String
    @Persisted var creationDate: Date
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, content: String, creationDate: Date = Date()) {
        self.init()
        self.title = title
        self.content = content
        self.creationDate = creationDate
    }
    
}

