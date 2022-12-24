//
//  ClosureViewController.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/08.
//

import UIKit

/*
 
 
 */

class ClosureViewController: UIViewController {

    @IBOutlet weak var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cardView.imageView
        cardView.likeButton.addTarget(self, action: #selector(touchLikeButton(_:)), for: .touchUpInside)

    }
    
    @IBAction func touchLikeButton(_ sender: UIButton) {
    }
    
    @IBAction func touchColorPickerButton(_ sender: UIButton) {
        showAlert(title: "컬러피커를 띄우겠습니까?", message: nil, okTitle: "띄우기") {
            // UIFontPickerViewController
            self.present(UIColorPickerViewController(), animated: true)
        }
    }
    
    @IBAction func touchChangeBackgroundButton(_ sender: UIButton) {
        showAlert(title: "배경색을 바꾸시겠습니까?", message: nil, okTitle: "바꾸기") {
            self.view.backgroundColor = .gray
        }
    }
    
    
    
}

extension UIViewController {
    
    func showAlert(title: String, message: String?, okTitle: String, okAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        let ok = UIAlertAction(title: okTitle, style: .default) { action in
            print(action.title)
            okAction()
            
        }
        
        alert.addAction(cancle)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
        
    }
    
}
