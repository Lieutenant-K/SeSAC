//
//  ViewController.swift
//  SecondProject
//
//  Created by 김윤수 on 2022/07/11.
//

import UIKit

enum MusicType: Int {
    
    case all = 0
    case korea = 1
    case other = 2
    
    
}


class ViewController: UIViewController {

    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchSegment(segment)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchSegment(_ sender: UISegmentedControl) {
        
        
        if segment.selectedSegmentIndex == MusicType.all.rawValue {
            
            
            
        } else if segment.selectedSegmentIndex == MusicType.korea.rawValue {
            
            
        } else if segment.selectedSegmentIndex == MusicType.other.rawValue {
            
            
        } else {
            
            
        }
        
        
        
        if segment.selectedSegmentIndex == 0 {
            
            label.text = "첫번째 세그먼트 선택"
            
        } else if segment.selectedSegmentIndex == 1{
            
            label.text = "두번째 세그먼트 선택"
        } else if segment.selectedSegmentIndex == 2 {
            
            label.text = "세번째 세그먼트 선택"
        } else {
            
            label.text = "오류"
        }
        
        
    }
    
    
    func example() -> (UIColor, String, String) {
        
        let color: [UIColor] = [.yellow, .red, .blue]
        let image: [String] = ["sesac_slime5", "sesac_slime6", "sesac_slime7", "sesac_slime8"]
        
        return (color.randomElement()!, "고래밥", image.randomElement()!)
        
    }
    
    func setUserNickname() -> String {
        
        let nickname = ["고래밥", "칙촉", "격투가"]
        let select = nickname.randomElement()!
        
        return "저는 \(select)입니다."
        
    }
    
    func showAlertController(){
        
        // 1. 흰 바탕 : UIAlertController
        let alert = UIAlertController(title: "타이틀", message: "메시지", preferredStyle: .alert)
        
        // 2. 버튼
        let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        let delete = UIAlertAction(title: "삭제", style: .destructive, handler: nil)
        
        // 3. 1+2
        
//        alert.addAction(cancel)
        alert.addAction(delete)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
//
        
    }


}

