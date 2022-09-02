//
//  RealmRepository.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import Foundation
import RealmSwift

final class MemoRealmRepository {
    
    private let localRealm = try! Realm()
    
    func addTask(task: Memo) throws {
        
        try localRealm.write {
            localRealm.add(task)
        }
        
    }
    
    func deleteTask(task: Memo) throws {
        
        if isExist(id: task.objectId) {
            try localRealm.write {
                localRealm.delete(task)
            }
        }

    }
    
    func updateTask(task: Memo, dataIntoUpdate: [String]) throws {
        
        if dataIntoUpdate.count == 0 {
            try deleteTask(task: task)
        } else {
            
            let title = dataIntoUpdate[0]
            let content = dataIntoUpdate.count > 1 ? dataIntoUpdate[1] : ""
            
            try localRealm.write {
                
                task.title = title
                task.content = content
                localRealm.add(task, update: .modified)
                
            }
            
        }
        

    }
    
    
    func fetchTasks() -> Results<Memo> {
        
        localRealm.objects(Memo.self).sorted(byKeyPath: "creationDate", ascending: false)

    }
    
    func isExist(id: ObjectId) -> Bool {
        return localRealm.object(ofType: Memo.self, forPrimaryKey: id) != nil ? true : false
    }
    
}
