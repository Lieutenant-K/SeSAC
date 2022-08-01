//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/28.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        textView.text = "rodxxx@naver.com 01099624047 06945 2022년 9월 21일"
        textView.textColor = .placeholderText
        
        textView.font = UIFont(name: "NanumKarGugSu", size: 17)
        textView.dataDetectorTypes = .all
//        textView.isEditable = false
        
        let attachment = NSTextAttachment(image: .init(systemName: "xmark")!)
        let attributedStr = NSAttributedString(string: "안녕하세요", attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.blue])
        
        textView.attributedText = .init(attachment: attachment)
    }

}

extension TranslateViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("begin")
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        if textView.text.isEmpty {
            textView.text = "플레이스홀더"
            textView.textColor = .placeholderText
        }
    }
}
