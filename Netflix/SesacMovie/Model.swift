//
//  Model.swift
//  SesacMovie
//
//  Created by 김윤수 on 2022/08/20.
//

import UIKit

enum TextFieldContentType {
    
    case email
    case password
    case nickname
    case code
    case none
    
    var placeholder: String {
        switch self {
        case .email:
            return "이메일 주소 또는 전화번호"
        case .nickname:
            return "닉네임"
        case .code:
            return "추천 코드 입력"
        case .password:
            return "비밀번호"
        default:
            return ""
            
        }
    }
    
    var regularEx: String? {
        switch self {
        case .email:
            return #"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"#
        case .code:
            return #"^[0-9]{5}$"#
        case .password:
            return #"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"#
        default:
            return nil
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .code:
            return .numberPad
        case .password, .nickname:
            return .asciiCapable
        default:
            return .default
        }
    }
    
    var validationCheckingMessage: (String, String) {
        switch self {
        case .email:
            return ("이메일 형식이 잘못됐습니다.", "올바른 이메일인지 확인해주세요")
        case .code:
            return ("코드 입력 오류", "5자리 숫자로 코드를 입력해주세요")
        case .password:
            return ("비밀번호 형식이 잘못됐습니다.", "영어 소문자, 대문자, 숫자 포함 8글자 이상")
        default:
            return ("잘못된 입력", "다시 입력해주세요")
        }
    }
}
