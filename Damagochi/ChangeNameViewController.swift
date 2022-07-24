//
//  ChangeNameViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/24.
//

import UIKit
import TextFieldEffects

class ChangeNameViewController: UIViewController {

    static let identifier = "ChangeNameViewController"
    
    @IBOutlet weak var textfield: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = TintColor.foreground
        view.backgroundColor = TintColor.background
        title = "아무개님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchSaveButton(_:)))
        
    }
    
    @objc func touchSaveButton(_ sender: UIBarButtonItem) {
        
        // 닉네임 저장
        
        navigationController?.popViewController(animated: true)
        
    }
    



}
