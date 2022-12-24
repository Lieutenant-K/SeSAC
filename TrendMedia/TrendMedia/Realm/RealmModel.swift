//
//  RealmModel.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/22.
//

import UIKit

import RealmSwift

protocol RealmUsableDelegate {
    
    func prepareToCloseRealm()
    
    func openRealm()
}

enum DesignatedPath {
    
    case imageDirectory
    case realmFile
    case zipFilePath(fileName: String)
    
    var path: String {
        switch self {
        case .imageDirectory:
            return "Image"
        case .realmFile:
            return "default.realm"
        case .zipFilePath(let fileName):
            return "\(fileName).zip"
        }
    }
}

class ShoppingItem: Object {
    
    @Persisted var itemName: String
    @Persisted var isComplete: Bool
    @Persisted var isFavorite: Bool
    @Persisted var creationDate: Date
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(name: String, complete: Bool = false, favorite: Bool = false, date: Date = Date()){
        self.init()
        itemName = name
        isComplete = complete
        isFavorite = favorite
        creationDate = date
    }
    
}
