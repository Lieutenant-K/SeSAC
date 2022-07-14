//
//  MemorialDayViewController.swift
//  SecondProject
//
//  Created by 김윤수 on 2022/07/13.
//

import UIKit

class MemorialDayViewController: UIViewController {

    
    @IBOutlet var memorialViews: [MemorialView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for view in memorialViews {
            setMemorialView(view: view)
        }
        

    }
    
    @IBAction func changePickerValue(_ sender: UIDatePicker) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy년 MM월 dd일"
        
        for view in memorialViews {
            view.dateLabel.text = dateFormat.string(from: sender.date.addingTimeInterval(TimeInterval(view.tag*100*60*60*24)))
        }
        
        
    }
    
    
    func setMemorialView(view: MemorialView){
        
        view.backgroundColor = .clear
        
        view.backgroundView.backgroundColor = .black
        view.backgroundView.alpha = 0.2
        view.backgroundView.layer.shadowOpacity = 1
        view.backgroundView.layer.shadowRadius = 5
        view.backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.backgroundView.layer.cornerRadius = 10
        
        view.imageView.layer.cornerRadius = 10
        view.imageView.backgroundColor = .clear
        view.imageView.image = UIImage(named: "image\(view.tag-1)")
        view.imageView.contentMode = .scaleAspectFill
        
        view.progressDayLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        view.progressDayLabel.textColor = .systemBackground
        view.progressDayLabel.text = "D+\(view.tag * 100)"
        
        
        view.dateLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        view.dateLabel.textColor = .systemBackground
        view.dateLabel.text = Date().formatted(date: .long, time: .omitted)
        
        
        
    }
    

  
}
