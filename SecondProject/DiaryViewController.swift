//
//  DiaryViewController.swift
//  SecondProject
//
//  Created by 김윤수 on 2022/07/11.
//

import UIKit

enum Emotions: String {
    case happy = "행복해"
    case love = "사랑해"
    case like = "좋아해"
    case upset = "화나"
    case hurt = "속상해"
    case depress = "우울해"
    case confuse = "당황해"
    case boring = "지루해"
    case sad = "슬퍼"
}

class DiaryViewController: UIViewController {
    
    @IBOutlet var images: [UIImageView]!
    @IBOutlet var buttons: [UIButton]!
    var emotions: [Emotions] = [.happy, .love, .like, .upset, .hurt, .depress, .confuse, .boring, .sad]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...images.count-1 {
            images[i].image = UIImage(named: "sesac_slime\(i+1)")
            buttons[i].setTitle(emotions[i].rawValue, for: .normal)
        }

    }
    
    @IBAction func touchButton(_ sender: UIButton){
        
        sender.setTitle(getString(currentTitle: sender.currentTitle!), for: .normal)
        
    }
    
    func getString(currentTitle: String) -> String {
        
        let titleElements = currentTitle.split(separator: " ")
        let newString = titleElements.count >= 2 ? String(titleElements[0]) + " \(Int(titleElements[1])! + 1)" : String(titleElements[0]) + " \(1)"
    
       return newString
        
        
    }

}
