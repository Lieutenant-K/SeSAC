//
//  SearchViewController.swift
//  NewlyCoinedWord
//
//  Created by 김윤수 on 2022/07/10.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet var hashtagButtons: [UIButton]!
    
    var newlyCoinedWords: [String: String] = ["삼귀다":"사귀기 전의 썸타는 단계라는 뜻입니다.",
                                              "갓생":"'갓'과 '인생'을 합친 말로 부지런하고 열심히 사는 사람에게 쓰는 말입니다.",
                                              "알잘딱깔센":"알아서 잘 딱 깔끔하고 센스있게의 줄임말입니다.",
                                              "Whyrano":"왜이러냐의 사투리 표현인 와이라노를 영어로 적은 말입니다.",
                                              "저메추":"'저녁메뉴 추천좀'의 줄임말로 점메추도 있습니다.",
                                              "너 뭐 돼?":"너가 혹시 뭐라도 돼? 라는 뜻으로 상대방의 행동이나 말이 마음에 들지 않을 때 사용할 수 있습니다.",
                                              "나 제법 젠틀해요":"어떤 과격적인 행동을 하고 싶다는 말을 여과없이 서술한 뒤에 나 제법 젠틀해요를 넣어 역설적인 방법을 연출할 때 사용합니다.",
                                              "ㅈㅂㅈㅇ":"'정보좀요'의 초성만 따서 제품에 대한 정보를 묻는 상황에서 많이 쓰입니다."]
    var currentHashTag: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchButton()
        setSearchTextField()
        for button in hashtagButtons{
            setHashTagButton(button: button)
        }
        setDescriptionLabel()
        backgroundImageView.image = UIImage(named: "background")

        // Do any additional setup after loading the view.
    }
    
    func setDescriptionLabel() {
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
    }
    
    func setSearchTextField(){
        
        searchTextField.borderStyle = .line
        searchTextField.layer.borderColor = UIColor.label.cgColor
        searchTextField.layer.borderWidth = 2
        searchTextField.backgroundColor = .systemBackground
        
    }
    
    func setSearchButton() {
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .systemBackground
        searchButton.backgroundColor = .label
        searchButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        
    }
    
    func setHashTagButton(button: UIButton){
        
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.cornerRadius = 8
        button.titleLabel?.numberOfLines = 1
        button.clipsToBounds = true
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitle(findAndGetNewWord(), for: .normal)
        
        
    }
    
    func findAndGetNewWord() -> String {
        
        while(true) {
            let word = newlyCoinedWords.keys.randomElement()
            if currentHashTag.contains(word!) {
                continue
            }
            currentHashTag.append(word!)
            return word!
        }
        
    }
    
    @IBAction func touchHashtagButton(_ sender: UIButton) {
        
        guard let title = sender.title(for: .normal) else { return }
        searchTextField.text = title
        descriptionLabel.text = newlyCoinedWords[title]
        sender.setTitle(findAndGetNewWord(), for: .normal)
        currentHashTag.remove(at: currentHashTag.firstIndex(of: title)!)
    }
    
    @IBAction func goSearch(_ sender: Any) {
        print("검색 시작")
        if let text = searchTextField.text, newlyCoinedWords.keys.contains(text) {
            descriptionLabel.text = newlyCoinedWords[text]
        }
        currentHashTag.removeAll()
        for button in hashtagButtons{
            button.setTitle(findAndGetNewWord(), for: .normal)
        }
        
        view.endEditing(true)
        
    }
    
    
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}
