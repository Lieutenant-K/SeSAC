//
//  MainViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit
import TextFieldEffects

class MainViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "person.circle"), style: .plain, target: self, action: #selector(touchSettingButton(_:)))
        
        // Color Setting
        view.backgroundColor = TintColor.background
        view.tintColor = TintColor.foreground
        bubbleView.backgroundColor = TintColor.background
        
        // View Setting
        configurateTextFields()
        configurateActionButtons()
        
        
        setMyDamagochi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = MyDamagochi.shared.userNickname + "님의 다마고치"
        
        dialogueLabel.text = MyDamagochi.dialogue.transitionDialogue()
        
    }
    
    func configurateActionButtons() {
        
        feedButton.setDamagochiName(title: "밥먹기", font: .systemFont(ofSize: 15, weight: .semibold))
        feedButton.setImage(.init(systemName: "drop.circle"), for: .normal)
        feedButton.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        drinkButton.setDamagochiName(title: "물먹기", font: .systemFont(ofSize: 15, weight: .semibold))
        drinkButton.setImage(.init(systemName: "leaf.circle"), for: .normal)
        drinkButton.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    func configurateTextFields() {
        
        feedTextField.borderInactiveColor = TintColor.foreground
        feedTextField.borderActiveColor = TintColor.foreground
        feedTextField.textColor = TintColor.foreground
        feedTextField.keyboardType = .numberPad
        
        
        drinkTextField.borderInactiveColor = TintColor.foreground
        drinkTextField.borderActiveColor = TintColor.foreground
        drinkTextField.textColor = TintColor.foreground
        drinkTextField.keyboardType = .numberPad
        
    }
    
    func setMyDamagochi() {
        
        let myDamagochi = MyDamagochi.shared
        
        dialogueLabel.setDamagochioLabel(text: "안아줘요", font: .systemFont(ofSize: 15, weight: .medium))
        
        nameButton.setDamagochiName(title: myDamagochi.type.name, font: .systemFont(ofSize: 15, weight: .medium))
        
        statusLabel.setDamagochioLabel(text: "LV\(myDamagochi.level) ∙ 밥알 \(Int(myDamagochi.rice))개 ∙ 물방울 \(Int(myDamagochi.water))개", font: .systemFont(ofSize: 14, weight: .bold))
        
        damagochiImageView.image = .init(named: "\(myDamagochi.typeNumber)-\(myDamagochi.level)")
        
    }
    
    @objc func touchSettingButton(_ sender: UIBarButtonItem) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SettingTableViewController.identifier) as! SettingTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func touchFeedButton(_ sender: UIButton) {
        
        var food = 0
        
        if let text = feedTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            
            guard let count = Int(text) else {
                self.view.makeToast("숫자만 입력해주세요", position: .center)
                return
            }
            food = count
        }
        else { food = 1 }
        
        if food >= 100 {
            self.view.makeToast("그러다 배가 터질 수도 있어요!", position: .center)
            dialogueLabel.text = MyDamagochi.dialogue.fullDialogue()
        }
        else {
            
            MyDamagochi.shared.rice += Double(food)
            
            damagochiImageView.image = .init(named: "\(MyDamagochi.shared.typeNumber)-\(MyDamagochi.shared.level)")
            
            statusLabel.setDamagochioLabel(text: "LV\(MyDamagochi.shared.level) ∙ 밥알 \(Int(MyDamagochi.shared.rice))개 ∙ 물방울 \(Int(MyDamagochi.shared.water))개", font: .systemFont(ofSize: 14, weight: .bold))
            
            feedTextField.text = nil
            dialogueLabel.text = MyDamagochi.dialogue.feedingDialogue()
        }
        
    }
    
    @IBAction func touchDrinkButton(_ sender: UIButton) {
        
        var drink = 0
        
        if let text = drinkTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            
            guard let count = Int(text) else {
                self.view.makeToast("숫자만 입력해주세요", position: .center)
                return
            }
            drink = count
        }
        else { drink = 1 }
        
        if drink >= 50 {
            self.view.makeToast("그러다 배가 터질 수도 있어요!", position: .center)
            dialogueLabel.text = MyDamagochi.dialogue.fullDialogue()
            
        }
        else {
            
            MyDamagochi.shared.water += Double(drink)
            
            damagochiImageView.image = .init(named: "\(MyDamagochi.shared.typeNumber)-\(MyDamagochi.shared.level)")
            
            statusLabel.setDamagochioLabel(text: "LV\(MyDamagochi.shared.level) ∙ 밥알 \(Int(MyDamagochi.shared.rice))개 ∙ 물방울 \(Int(MyDamagochi.shared.water))개", font: .systemFont(ofSize: 14, weight: .bold))
            
            drinkTextField.text = nil
            dialogueLabel.text = MyDamagochi.dialogue.feedingDialogue()
            
        }
        
    }
    
    @IBAction func tapBackgroundView(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
}
