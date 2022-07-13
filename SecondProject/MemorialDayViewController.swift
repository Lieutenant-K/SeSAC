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
    
    func setMemorialView(view: MemorialView){
        
        view.backgroundColor = .clear
        
        view.backgroundView.layer.cornerRadius = 10
        view.backgroundView.backgroundColor = .black
        view.backgroundView.alpha = 0.1
        view.backgroundView.layer.shadowOpacity = 1
        view.backgroundView.layer.shadowRadius = 5
        view.backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        view.imageView.layer.cornerRadius = 10
        view.imageView.backgroundColor = .clear
        view.imageView.image = UIImage(named: "cake")
        view.imageView.contentMode = .scaleAspectFill
        
        view.progressDayLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        view.progressDayLabel.textColor = .systemBackground
        
        view.dateLabel.font = .systemFont(ofSize: 15, weight: .regular)
        view.dateLabel.textColor = .systemBackground
        
        
    }
    

  
}
