//
//  LoginViewModel.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/09/01.
//

import Foundation

class LoginViewModel {
    
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var nickname: Observable<String> = Observable("")
    var isValid = Observable(false)
    
    func checkValidation() {
        
        isValid.value = email.value.count >= 6 && password.value.count >= 4 ? true : false
        
    }
    
    func signIn(completion: @escaping () -> Void) {
        
        UserDefaults.standard.set(nickname.value, forKey: "nickname")
        
        completion()
    }
    
}
