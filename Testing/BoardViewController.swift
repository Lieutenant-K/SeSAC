//
//  BoardViewController.swift
//  Testing
//
//  Created by 김윤수 on 2022/07/06.
//

import UIKit


class BoardViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
        setButton(button: button1, title: "전송", highlited: "보내기")
        setButton(button: button2, title: "버튼", highlited: "하하")
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 50, weight: .bold)
        
    }
    
    func setTextField() {
        
        textfield.placeholder = "내용을 입력해주세요"
        textfield.text = "미리 입력된 내용"
        textfield.keyboardType = .emailAddress
        
    }
        
    func setButton(button: UIButton, title: String, highlited: String) {
        
        button.setTitle(title, for: .normal)
        button.setTitle(highlited, for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.setTitleColor(.cyan, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        
        for item in buttonList {
            item.backgroundColor = .purple
            item.layer.cornerRadius = 2
        }
        
    }
    
    @IBAction func endTextfield(_ sender: UITextField) {
        
        print("언제 호출될끼?")
    }
    @IBAction func touchButton1(_ sender: UIButton) {
        
//        print(textfield.text?.count)
        
        label.text = textfield.text
    }

    @IBAction func keyboardDismiss(_ sender: Any) {
        topView.isHidden.toggle()
        view.endEditing(true)
        
    }
}
