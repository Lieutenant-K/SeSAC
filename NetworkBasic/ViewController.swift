//
//  ViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController {
    
    var newTitle: String = "프로토콜로 추가한 타이틀"
    
    var backgroundColor: UIColor = .blue
    
    func configureView() {
        
        newTitle = "메소드에서 변경된 프로토콜 프로퍼티"
        
        
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

