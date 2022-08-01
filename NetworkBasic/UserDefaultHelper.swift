//
//  UserDefaultHelper.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/01.
//

import Foundation

class UserDefaultHelper {
    
    static let standard = UserDefaultHelper() // singleton Pattern
    //자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        
        case nickname, age
        
    }
    
    var nickname: String {
        get {
            userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    private init() { }
    
}
