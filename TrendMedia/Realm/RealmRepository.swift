//
//  RealmRepository.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/27.
//

import Foundation

import RealmSwift

protocol RealmRepository {
    
    associatedtype Item: RealmCollectionValue
    
    var localRealm: Realm { get }
    
    func fetch(sortKey: String) -> Results<Item>
    
    func delete(taskToDelete: Item)
    
    func update(updateHandler: () -> Void)
    
    func add(taskToAdd: Item)
    
}

class ShoppingRepository: RealmRepository {
    
    let localRealm = try! Realm()
    
    func fetch(sortKey: String) -> Results<ShoppingItem> {

        return localRealm.objects(ShoppingItem.self).sorted(byKeyPath: sortKey, ascending: true)

    }
    
    func delete(taskToDelete: ShoppingItem) {
        
        try! localRealm.write {
            
            ImageFileManager.shared.removeImageFromDocument(fileName: taskToDelete.objectId.stringValue)
            
            localRealm.delete(taskToDelete)
            
        }
        
    }
    
    func update(updateHandler: () -> Void) {
        
        
        try! localRealm.write {
            
            updateHandler()
            
        }
        
    }
    
    func add(taskToAdd: ShoppingItem) {
        
        try! localRealm.write {
            
            localRealm.add(taskToAdd)
            
        }
        
    }
    
}
