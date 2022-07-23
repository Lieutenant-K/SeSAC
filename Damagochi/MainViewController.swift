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
        view.backgroundColor = TintColor.background
        view.tintColor = TintColor.foreground
        bubbleView.backgroundColor = TintColor.background
        dialogueLabel.setDamagochioLabel(text: "안아줘요", font: .systemFont(ofSize: 15, weight: .medium))
        nameButton.setDamagochiName(title: "다마고치 이름", font: .systemFont(ofSize: 15, weight: .medium))
        statusLabel.setDamagochioLabel(text: "상태 바", font: .systemFont(ofSize: 14, weight: .bold))
        configurateTextFields()
        configurateActionButtons()
        
       
        title = "아무개님의 다마고치"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "gearshape"), style: .plain, target: self, action: #selector(touchSettingButton(_:)))
        
        
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
        
        
        drinkTextField.borderInactiveColor = TintColor.foreground
        drinkTextField.borderActiveColor = TintColor.foreground
        drinkTextField.textColor = TintColor.foreground
        
        
    }
    
    @objc func touchSettingButton(_ sender: UIBarButtonItem) {
        
        
        
    }
    

}
