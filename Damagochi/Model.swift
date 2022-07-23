//
//  Model.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit

enum DamagochiType: Int, CaseIterable {
    
    case spike = 1
    case sun
    case star
    case none
    
    var name: String {
        switch self {
        case .spike:
            return "따끔따끔 다마고치"
        case .sun:
            return "방실방실 다마고치"
        case .star:
            return "반짝반짝 다마고치"
        case .none:
            return "준비중이에요"
        }
    }
    
    var thumbnail: UIImage? {
        return self == .none ? .init(named: "noImage") : .init(named: "\(self.rawValue)-6")
    }
    
    var desription: String {
        switch self {
        case .spike:
            return "따끔따끔 다마고치입니다."
        case .sun:
            return "방실방실 다마고치입니다."
        case .star:
            return "반짝반짝 다마고치입니다."
        case .none:
            return "준비중이에요"
        }
    }
}

struct TintColor {
    
    // 왜 정수로 입력하면 잘 되다가 안되지?
    static let background = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    static let foreground = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    
}
