//
//  SecondViewController.swift
//  SesacDelivery
//
//  Created by 김윤수 on 2022/07/05.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerImageView.image = UIImage(named: "banner0\(Int.random(in: 1...3))")
        bannerImageView.layer.cornerRadius = 25
        bannerImageView.layer.borderColor = UIColor.yellow.cgColor
        bannerImageView.layer.borderWidth = 5
        
        
        label.text = "베달의 민족"
        label.backgroundColor = .blue
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        
        print("Github test")
        
        // Do any additional setup after loading the view.
    }

    @IBAction func resultButtonAction(_ sender: UIButton) {
        
        bannerImageView.image = UIImage(named: "banner0\(Int.random(in: 1...3))")
        
    }
}
