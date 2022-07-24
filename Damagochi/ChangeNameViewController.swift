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
        
        title = MyDamagochi.shared.userNickname + "님 이름 정하기"
        textfield.text = MyDamagochi.shared.userNickname
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchSaveButton(_:)))
        
    }
    
    @objc func touchSaveButton(_ sender: UIBarButtonItem) {
        
        // 닉네임 저장
        
        guard let text = textfield.text?.trimmingCharacters(in: .whitespaces), (2...6).contains(text.count) else { return }
        
        MyDamagochi.shared.userNickname = text
        
        navigationController?.popViewController(animated: true)
        
    }
    



}
