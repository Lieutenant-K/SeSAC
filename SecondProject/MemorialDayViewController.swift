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
            view.pressGestureRecognizer.addTarget(self, action: #selector(pressMemorialView(_:)))
        }
        

    }
    
    @IBAction func changePickerValue(_ sender: UIDatePicker) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy년 MM월 dd일"
        
        for view in memorialViews {
            view.dateLabel.text = dateFormat.string(from: sender.date.addingTimeInterval(TimeInterval(view.tag*100*60*60*24)))
        }
        
        
    }
    
    
    @IBAction func pressMemorialView(_ sender: UILongPressGestureRecognizer) {
        
        guard let key = sender.view?.tag else { return }
        
        let alertController = UIAlertController(title: "이 날짜를 기념일로 등록하시겠습니까?", message: "", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            UserDefaults.standard.removeObject(forKey: "\(key)")
            self.memorialViews[key-1].dateLabel.text = nil
        }))
        
        alertController.addAction(UIAlertAction(title: "등록", style: .default, handler: { _ in
            let value = self.memorialViews[key-1].dateLabel.text
            UserDefaults.standard.set(value, forKey: "\(key)")
            //            print(UserDefaults.standard.string(forKey: "\(key)"))
        }))
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alertController, animated: true)
        
        
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
        view.dateLabel.text = UserDefaults.standard.string(forKey: "\(view.tag)")
        //Date().formatted(date: .long, time: .omitted)
        
        
        
    }
    

  
}
