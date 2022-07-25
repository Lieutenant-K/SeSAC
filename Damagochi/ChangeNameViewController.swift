//
//  ChangeNameViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/24.
//

import UIKit
import TextFieldEffects
import Toast

class ChangeNameViewController: UIViewController {

    
    // MARK: - Properties
    
    static let identifier = "ChangeNameViewController"
    
    @IBOutlet weak var textfield: HoshiTextField!
    
    // MARK: - Method
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = TintColor.foreground
        view.backgroundColor = TintColor.background
        
        title = MyDamagochi.shared.userNickname + "님 이름 정하기"
        textfield.text = MyDamagochi.shared.userNickname
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchSaveButton(_:)))
        
    }
    
    // MARK: Action Method
    
    @objc func touchSaveButton(_ sender: UIBarButtonItem) {
        
        // 닉네임 저장
        
        guard let text = textfield.text?.trimmingCharacters(in: .whitespaces), (2...6).contains(text.count)
        else {
            self.view.makeToast("공백 제외 2~6 글자만 가능합니다.", position: .center)
            return }
        
        MyDamagochi.shared.userNickname = text
        
        navigationController?.popViewController(animated: true)
        
    }
    



}
