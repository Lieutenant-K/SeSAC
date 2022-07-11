//
//  ViewController.swift
//  SecondProject
//
//  Created by 김윤수 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 1.9
        shadowView.layer.shadowOffset = CGSize(width: 50, height: 50)
        
        // Do any additional setup after loading the view.
    }


}

