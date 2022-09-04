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
    
    func updateTaskWithData(task: Memo, dataToUpdate: MemoContent?) throws {
        
        if let data = dataToUpdate {
            
            try localRealm.write {
                
                task.title = data.title
                task.subtitle = data.subtitle
                task.content = data.content
//                localRealm.add(task, update: .modified)
                
            }
        } else {
            try deleteTask(task: task)
        }
        
    }
    
    func updateTask(updateHandler: () -> ()) throws {
        
        try localRealm.write{
            updateHandler()
        }
        
    }
    
    
    func fetchTasks() -> Results<Memo> {
        
        localRealm.objects(Memo.self).sorted(byKeyPath: "creationDate", ascending: false)
        
    }
    
    func isExist(id: ObjectId) -> Bool {
        return localRealm.object(ofType: Memo.self, forPrimaryKey: id) != nil ? true : false
    }
    
    func getURL() {
        print(localRealm.configuration.fileURL!)
    }
    
}
