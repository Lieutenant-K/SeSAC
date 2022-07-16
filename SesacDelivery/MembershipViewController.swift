//
//  MembershipViewController.swift
//  SesacDelivery
//
//  Created by 김윤수 on 2022/07/11.
//

import UIKit

class MembershipViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var topCardView: UIView!
    @IBOutlet weak var middleCardView: UIView!
    @IBOutlet weak var bottomCardView: UIView!
    
    @IBOutlet var autoPointLabels: [UILabel]!
    @IBOutlet var cards: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for card in cards{
            setCardView(view: card)
        }
        
        for label in autoPointLabels{
            setAutoPointLabels(label: label)
        }

        
    }
    
    func setCardView(view: UIView){
        
//        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        
    }
    
    func setAutoPointLabels(label: UILabel){
        
        label.text = " 자동적립 "
        label.backgroundColor = .black
        label.textColor = .white
        label.layer.opacity = 0.8
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        
        
    }
    
}
