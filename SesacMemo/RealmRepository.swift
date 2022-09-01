//
//  RealmRepository.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import Foundation
import RealmSwift

class MemoRealmRepository {
    
    let localRealm = try! Realm()
    
    func addTask(task: Memo) {
        
        do {
            try localRealm.write{
                localRealm.add(task)
            }
        } catch {
            print(error)
        }
        
    }
    
    func deleteTask(task: Memo) {
        
        do {
            try localRealm.write{
                localRealm.delete(task)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchTasks() -> Results<Memo> {
        
        localRealm.objects(Memo.self)
        
        
    }
    
}
