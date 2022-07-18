//
//  ViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var constaraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        label.text = dateFormatter.string(from: sender.date)
        
    }
    func configurationLabel() {
        for i in labelCollection {
            i.font = .systemFont(ofSize: 20)
            i.textColor = .red
        }
        
        let labelArray = [label, label2]
        for i in labelArray {
            i?.font = .systemFont(ofSize: 20)
            i?.textColor = .red
        }
    }
}

