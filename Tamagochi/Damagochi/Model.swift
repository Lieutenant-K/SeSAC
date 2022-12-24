//
//  Model.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit

enum DamagochiStyle: Int, CaseIterable {
    
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
                    물을 좋아하고 조금만 먹어도 오래 살 수 있습니다.
                    다가가기 힘들지만 누구보다 귀여운 다마고치에요.
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
                    제 친구들은 모두 하늘에 있어서 좀 외로웠는데
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
    
    static let dialogue = DamagochiDialouge()
    
    let foodMaxLimit = 100
    
    let waterMaxLimit = 50
    
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
    
    var statusString: String {
        "LV\(level) ∙ 밥알 \(Int(rice))개 ∙ 물방울 \(Int(water))개"
    }
    
    var image: UIImage? {
        UIImage(named: "\(typeNumber)-\(level)")
    }
    
    @UserDefault(key: "type", defaultValue: DamagochiStyle.none.rawValue)
    var typeNumber: Int
    
    @UserDefault(key: "riceCount", defaultValue: 0)
    var rice: Double
    
    @UserDefault(key: "waterCount", defaultValue: 0)
    var water: Double
    
    @UserDefault(key: "userNickname", defaultValue: "대장")
    var userNickname: String
    
    var type: DamagochiStyle {
        get { DamagochiStyle(rawValue: typeNumber) ?? .none }
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

struct DamagochiDialouge {
    
    private var transition: [String] {
        let name = MyDamagochi.shared.userNickname
        let dialogue = [
            "\(name)님, 어디갔다가 오시는거에요~!",
            "\(name)님 오늘은 뭐하고 놀까요?",
            "너무 보고싶었어요~ \(name)님~",
            "기다리다가 지칠 뻔 했다구요~ \(name)님~",
        ]
        return dialogue
    }
    
    private let feeding: [String] = [
        "이제 좀 살 것 같아요~",
        "금강산도 식후경!",
        "더 주세요~!",
        "너무 커버리면 어쩌죠?"
    ]
    
    private let full: [String] = [
        "배가 터져버릴 것 같아요...",
        "으아 배불러~~~~~",
        "그렇게 많이는 못먹어요 ㅜㅜ",
        "토할 것 같아..."
    ]
    
    var transitionDialogue: String? {
        transition.randomElement()
    }
    
    
    var feedingDialogue: String? {
        feeding.randomElement()
    }
    
    var fullDialogue: String? {
        full.randomElement()
    }
    
    
}
