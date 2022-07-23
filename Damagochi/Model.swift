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
            return "따끔따금 다마고치"
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
}

