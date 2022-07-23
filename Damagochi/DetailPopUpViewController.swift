//
//  DetailPopUpViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit

class DetailPopUpViewController: UIViewController {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    static let identifier = "DetailPopUpViewController"
    
    var type: DamagochiType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewBackground()
        
        thumbnailImageView.image = type?.thumbnail
        nameButton.setDamagochiName(title: type?.name, font: .systemFont(ofSize: 15, weight: .semibold))
        descriptionLabel.setDamagochioLabel(text: type?.desription, font: .systemFont(ofSize: 15))
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.backgroundColor = TintColor.foreground.withAlphaComponent(0.1)
//        cancelButton.
        startButton.setTitle("시작하기", for: .normal)
       
        
    }
    
    func setViewBackground() {
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.tintColor = TintColor.foreground
        
        containerView.backgroundColor = TintColor.foreground
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        contentView.backgroundColor = TintColor.background
        
        buttonStackView.backgroundColor = TintColor.background
        
        lineView.backgroundColor = TintColor.foreground
        
        
        
    }
    
    @IBAction func touchCancelButton(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func touchStartButton(_ sender: UIButton) {
    }
}
