//
//  MainViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit
import TextFieldEffects

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var damagochiImageView: UIImageView!
    @IBOutlet weak var dialogueLabel: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var feedTextField: HoshiTextField!
    @IBOutlet weak var drinkTextField: HoshiTextField!
    
    static let identifier = "MainViewController"
    
    
    // MARK: - Method
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "person.circle"), style: .plain, target: self, action: #selector(touchSettingButton(_:)))
        
        // Color Setting
        view.backgroundColor = TintColor.background
        view.tintColor = TintColor.foreground
        bubbleView.backgroundColor = TintColor.background
        
        // View Setting
        configurateTextField(textfield: feedTextField)
        configurateTextField(textfield: drinkTextField)
        configurateActionButton(button: feedButton, title: "밥먹기", image: .init(systemName: "drop.circle"))
        configurateActionButton(button: drinkButton, title: "물먹기", image: .init(systemName: "leaf.circle"))
        
        
        setMyDamagochi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = MyDamagochi.shared.userNickname + "님의 다마고치"
        
        dialogueLabel.text = MyDamagochi.dialogue.transitionDialogue()
        
    }
    
    // MARK: Configuration View Method
    func configurateActionButton(button: UIButton, title: String, image: UIImage?) {
        
        button.setDamagochiName(title: title, font: .systemFont(ofSize: 15, weight: .semibold))
        button.setImage(image, for: .normal)
        button.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    func configurateTextField(textfield: HoshiTextField) {
        
        textfield.borderInactiveColor = TintColor.foreground
        textfield.borderActiveColor = TintColor.foreground
        textfield.textColor = TintColor.foreground
        textfield.keyboardType = .numberPad
        
    }
    
    func setMyDamagochi() {
        
        let myDamagochi = MyDamagochi.shared
        
        dialogueLabel.setDamagochiLabel(text: "", font: .systemFont(ofSize: 15, weight: .medium))
        
        nameButton.setDamagochiName(title: myDamagochi.type.name, font: .systemFont(ofSize: 15, weight: .medium))
        
        statusLabel.setDamagochiLabel(text: "LV\(myDamagochi.level) ∙ 밥알 \(Int(myDamagochi.rice))개 ∙ 물방울 \(Int(myDamagochi.water))개", font: .systemFont(ofSize: 14, weight: .bold))
        
        damagochiImageView.image = .init(named: "\(myDamagochi.typeNumber)-\(myDamagochi.level)")
        
    }
    
    // MARK: Other Method
    func feed(textfield: UITextField, maxLimit: Int) -> Int {
        
        var food = 0
        
        if let text = textfield.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            
            guard let count = Int(text) else {
                self.view.makeToast("숫자만 입력해주세요", position: .center)
                return 0
            }
            
            food = count
        }
        else { food = 1 }
        
        if food >= maxLimit {
            self.view.makeToast("배가 터질 수도 있어요!", position: .center)
            dialogueLabel.text = MyDamagochi.dialogue.fullDialogue()
            return 0
        }
        else {
            dialogueLabel.text = MyDamagochi.dialogue.feedingDialogue()
            
            textfield.text = nil
            
            return food
        }
        
    }
    
    func updateDamagochiStatus() {
        
        damagochiImageView.image = .init(named: "\(MyDamagochi.shared.typeNumber)-\(MyDamagochi.shared.level)")
        
        statusLabel.setDamagochiLabel(text: "LV\(MyDamagochi.shared.level) ∙ 밥알 \(Int(MyDamagochi.shared.rice))개 ∙ 물방울 \(Int(MyDamagochi.shared.water))개", font: .systemFont(ofSize: 14, weight: .bold))
        
        
    }
    
    // MARK: Action Method
    @objc func touchSettingButton(_ sender: UIBarButtonItem) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SettingTableViewController.identifier) as! SettingTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBAction func touchFeedButton(_ sender: UIButton) {
        
        MyDamagochi.shared.rice += Double(feed(textfield: feedTextField, maxLimit:  MyDamagochi.shared.foodMaxLimit))
        
        updateDamagochiStatus()
        
    }
    
    @IBAction func touchDrinkButton(_ sender: UIButton) {
        
        MyDamagochi.shared.water += Double(feed(textfield: drinkTextField, maxLimit:  MyDamagochi.shared.waterMaxLimit))
        
        updateDamagochiStatus()
        
    }
    
    @IBAction func tapBackgroundView(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
}
