//
//  Observable.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/08/31.
//

import Foundation

class Observable<T> { // 양방향 바인딩
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
    
}

class User {
    
    private var listener: (() -> Void)?
    
    var value: String {
        didSet {
            listener?()
        }
    }
    
    init(_ value: String) {
        self.value = value
    }
    
    func bind(completionHandler: @escaping () -> Void) {
        completionHandler()
        listener = completionHandler
    }
    
}
