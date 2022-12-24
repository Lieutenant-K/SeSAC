//
//  DetailPopUpViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit

class DetailPopUpViewController: UIViewController {
    
    // MARK: - Properties
    
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
    
    var type: DamagochiStyle
    
    
    // MARK: - Method
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewBackground()
        configurateActionButtons()
        configurateDescriptionLabel()
        thumbnailImageView.image = type.thumbnail
        nameButton.setDamagochiName(title: type.name, font: .systemFont(ofSize: 15, weight: .semibold))
        
    }
    
    
    // MARK: Configuration View Method
    func setViewBackground() {
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.tintColor = TintColor.foreground
        
        containerView.backgroundColor = .tintColor
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        contentView.backgroundColor = TintColor.background
        
        buttonStackView.backgroundColor = TintColor.background
        
        lineView.backgroundColor = .tintColor
        
    
    }
    
    func configurateActionButtons() {
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        cancelButton.backgroundColor = TintColor.foreground.withAlphaComponent(0.1)
        
        let title = MyDamagochi.shared.type == .none ? "시작하기" : "변경하기"
        startButton.setTitle(title, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        
    }
    
    func configurateDescriptionLabel() {
        
        descriptionLabel.setDamagochiLabel(text: type.desription, font: .systemFont(ofSize: 15))
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
    // MARK: Action Method
    @IBAction func touchCancelButton(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func touchStartButton(_ sender: UIButton) {
        
        let scene = UIApplication.shared.connectedScenes.first
        let delegate = scene?.delegate as! SceneDelegate
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
        
        let navi = UINavigationController(rootViewController: vc)
        
        // Setting NaviBar Appearance
        navi.setDamagochiBarAppearance()
        
//        guard let type = type else { return }
        
        MyDamagochi.shared.type = type
        
        delegate.window?.rootViewController = navi
        delegate.window?.makeKeyAndVisible()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init?(coder: NSCoder, type: DamagochiStyle){
        self.type = type
        super.init(coder: coder)
    }
    
}
