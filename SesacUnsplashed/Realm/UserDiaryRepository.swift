//
//  UserDiaryRepository.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/26.
//

import Foundation

import RealmSwift

protocol UserDiaryRepositoryType {
    
    func fetch(sortKey: String) -> Results<UserDiary>
    
    func fetchDate(date: Date) -> Results<UserDiary>
    
    func filter(containWord: String) -> Results<UserDiary>
    
    func updateFavorite(taskToUpdate: UserDiary)
    
    func delete(taskToDelete: UserDiary) throws
    
    func addItem(item: UserDiary) throws
}

class UserDiaryRepository: UserDiaryRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetch(sortKey: String) -> Results<UserDiary> {
        
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sortKey, ascending: true)
        
    }
    
    func fetchDate(date: Date) -> Results<UserDiary> {
        
        
        return localRealm.objects(UserDiary.self).where {
            $0.diaryDate >= date && $0.diaryDate < Date(timeInterval: 86400, since: date)
        }
        
    }
    
    func filter(containWord: String) -> Results<UserDiary> {
        
        return localRealm.objects(UserDiary.self).where({
            $0.diaryTitle.contains(containWord)
        })
        
    }
    
    func updateFavorite(taskToUpdate: UserDiary) {
        
        try! localRealm.write {
            
            taskToUpdate.favorite.toggle()
            
            // favorite 프로퍼티(컬럼) 에 해당하는 모든 값 변경
            //                self.tasks.setValue(true, forKey: "favorite")
                            
                            // 특정 objectId(PK)에 해당하는 레코드의 diaryTitle 컬럼 값 변경
            //                self.repository.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "diaryTitle":"수정된 제목"], update: .modified)
            
        }
        
    }
    
    func delete(taskToDelete: UserDiary) throws {
        
        try localRealm.write {
            
            localRealm.delete(taskToDelete)
        }
        
    }
    
    func addItem(item: UserDiary) throws {
        
        
        try localRealm.write {
            localRealm.add(item)
            
        }
        
    }
    
    
    
}
