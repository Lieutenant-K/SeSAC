//
//  RealmModel.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/22.
//

import Foundation
import RealmSwift

// UserDiary: 테이블, 스키마 이름
// @Persisted : 컬럼
class UserDiary: Object {
    
    @Persisted var diaryTitle: String
    @Persisted var diaryContent: String?
    @Persisted var diaryDate = Date()
    @Persisted var postingDate = Date()
    @Persisted var favorite: Bool
    @Persisted var photo: String?
    
    // PK(필수) : Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, content: String?, diaryDate: Date, postingDate: Date, photo: String?) {
        self.init()
        self.diaryTitle = title
        self.diaryContent = content
        self.diaryDate = diaryDate
        self.postingDate = postingDate
        self.photo = photo
        
    }
    
}
