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
            return """
                    안녕하세요 저는 따끔따끔 다마고치에요.
                    가시가 많아서 다칠 수 있으니 조심히 만져주세요.
                    사막에 살기 때문에 물을 좋아하고 조금만 먹어도 오래 살 수 있습니다.
                    겉모습은 다가가기 힘들어도 친해지면 누구보다 귀여운 다마고치에요.
                    """
        case .sun:
            return """
                    방갑습니다 저는 방실방실 다마고치입니다.
                    하루종일 빛나면서 다른 사람들을 지켜보는게 취미입니다.
                    가끔 구름때문에 안보일때가 있지만 가출한게 아니니까 걱정하지 마세요.
                    저의 밝은 에너지를 주인님께 꼭 드리고 싶어요.
                    """
        case .star:
            return """
                    저는 반짝반짝 다마고치라고 해요.
                    우주여행을 하다가 이 곳이 너무 예뻐서 정착했어요.
                    제 친구들은 전부 하늘에 있어서 여기 있는 동안 엄청 외로웠는데
                    주인님을 만나서 너무 좋아요 하하~!
                    """
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

class MyDamagochi {
    

    var level: Int {
        let value = (rice / 5.0) + (water / 2.0)
        if value < 10 {
            return 1
        }
        else if value < 100 {
            return Int(value / 10)
        }
        else {
            return 10
        }
    }
    
    @UserDefault(key: "type", defaultValue: DamagochiType.none.rawValue)
    var typeNumber: Int
    
    @UserDefault(key: "riceCount", defaultValue: 0)
    var rice: Double
    
    @UserDefault(key: "waterCount", defaultValue: 0)
    var water: Double
    
    @UserDefault(key: "userNickname", defaultValue: "대장")
    var userNickname: String
    
    var type: DamagochiType {
        get { DamagochiType(rawValue: typeNumber) ?? .none }
        set { typeNumber = newValue.rawValue }
    }
    
    
    static let shared = MyDamagochi()
    
    private init(){}
    
}

@propertyWrapper
struct UserDefault<T> {
    
    var key: String
    var defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
        
    }
    
}


