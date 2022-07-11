//
//  DiaryViewController.swift
//  SecondProject
//
//  Created by 김윤수 on 2022/07/11.
//

import UIKit

class DiaryViewController: UIViewController {
    
    @IBOutlet var images: [UIImageView]!
    @IBOutlet var buttons: [UIButton]!
    var emotions: [String] = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "지루해", "슬퍼해"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...images.count-1 {
            images[i].image = UIImage(named: "sesac_slime\(i+1)")
            buttons[i].setTitle(emotions[i], for: .normal)
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchButton(_ sender: UIButton){
        
        guard let title = sender.title(for: .normal)?.split(separator: " ") else { return }
    
        if title.count >= 2 {
            let number = Int(title[1]) ?? 0
            sender.setTitle(String(title[0]) + " \(number + 1)", for: .normal)
            
        }
        else {
            
            sender.setTitle(String(title[0]) + " \(1)", for: .normal)
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
