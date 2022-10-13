//
//  AppDelegate.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 {
                
            }
            
            if oldSchemaVersion < 2 {
                
                migration.renameProperty(onType: Memo.className(), from: "isFavorite", to: "isPinned")
            }
            
            if oldSchemaVersion < 3 {
                migration.enumerateObjects(ofType: Memo.className()) { oldObject, newObject in
                    
                    guard let new = newObject else { return }
                    
                    new["isFavorite"] = false
                    
                }
            }
            
            if oldSchemaVersion < 4 {
                
                migration.enumerateObjects(ofType: Memo.className()) { oldObject, newObject in
                    
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["overview"] = "\(old["title"]!) + \(old["subtitle"]!)"
                    
                }
            }
            
            if oldSchemaVersion < 5 {
                
                migration.deleteData(forType: Memo.className())
                
            }
            
            if oldSchemaVersion < 6 {
                
                let value: [String: Any] = ["title":"새로 생성됨", "subtitle": "새로 생성됨", "creationDate": Date()]
                
                migration.create(Memo.className(),value: value)
                
            }
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

