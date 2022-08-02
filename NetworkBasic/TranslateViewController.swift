//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var textCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        textView.textColor = .placeholderText
        textView.text = "번역할 문장을 입력해주세요"
        textView.font = UIFont(name: "NanumKarGugSu", size: 17)
        
        translatedTextView.font = UIFont(name: "NanumKarGugSu", size: 17)
        translatedTextView.isEditable = false
        
//        requestTranslate()
        
        /*
         textView.dataDetectorTypes = .all
         textView.isEditable = false
         
         let attachment = NSTextAttachment(image: .init(systemName: "xmark")!)
         let attributedStr = NSAttributedString(string: "안녕하세요", attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.blue])
         
         textView.attributedText = .init(attachment: attachment)
         */
    }
    
    func requestTranslate(text: String) {
        
        let url = EndPoint.translateURL
        
        let header: HTTPHeaders = ["X-Naver-Client-Id":APIKey.NAVER, "X-Naver-Client-Secret":APIKey.NAVERKEY]
        
        let parameters: Parameters = ["source": "ko", "target": "en", "text": text]
        
        AF.request(url, method: .post,parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print(json)
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    self.translatedTextView.text = json["message"]["result"]["translatedText"].stringValue
                } else {
                    self.translatedTextView.text = json["errorMessage"].stringValue
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    @IBAction func touchTranslateButton(_ sender: UIButton) {
        
        requestTranslate(text: textView.text!)
        
    }
}


extension TranslateViewController: UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
        textCountLabel.text = textView.text.count.formatted(IntegerFormatStyle.number) + "자"
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        print("begin")
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        print("End")
        if textView.text.isEmpty {
            textView.text = "번역할 문장을 입력해주세요"
            textView.textColor = .placeholderText
        }
    }
}
