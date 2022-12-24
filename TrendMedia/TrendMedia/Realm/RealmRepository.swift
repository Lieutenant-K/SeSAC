//
//  RealmRepository.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/27.
//

import Foundation

import RealmSwift

private protocol RealmRepository {
    
    associatedtype RealmObject: RealmCollectionValue
    
    var localRealm: Realm { get }
    
    func fetch(sortKey: String) -> Results<RealmObject>
    
    func delete(taskToDelete: RealmObject) throws
    
    func update(updateHandler: () -> Void) throws
    
    func add(taskToAdd: RealmObject) throws
    
}

final class ShoppingRepository: RealmRepository {
    
    fileprivate let localRealm = try! Realm()
    
    func fetch(sortKey: String) -> Results<ShoppingItem> {

        return localRealm.objects(ShoppingItem.self).sorted(byKeyPath: sortKey, ascending: true)

    }
    
    func delete(taskToDelete: ShoppingItem) throws {
        
        try localRealm.write {
            
            ImageFileManager.shared.removeImageFromDocument(fileName: taskToDelete.objectId.stringValue)
            
            localRealm.delete(taskToDelete)
            
        }
        
    }
    
    func update(updateHandler: () -> Void) throws {
        
        
        try localRealm.write {
            
            updateHandler()
            
        }
        
    }
    
    func add(taskToAdd: ShoppingItem) throws {
        
        try localRealm.write {
            
            localRealm.add(taskToAdd)
            
        }
        
    }
    
    deinit {
        print(#function, String(describing: self))
    }
    
}
