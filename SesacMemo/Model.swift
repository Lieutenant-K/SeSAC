//
//  Model.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/02.
//

import Foundation
import UIKit

struct MemoContent {
    
    @DefaultMemo(text: "", defaultValue: "새로운 메모")
    var title: String
    
    @DefaultMemo(text: "", defaultValue: "추가 텍스트 없음")
    var subtitle: String
    
    var content: String = ""
    
    init(title: String = "", subtitle: String = "", content: String = "") {
        self.title = title
        self.subtitle = subtitle
        self.content = content
    }
    
}

@propertyWrapper
struct DefaultMemo {
    
    var text: String
    let defaultValue: String
    
    var wrappedValue: String {
        get { text == "" ? defaultValue : text }
        set { text = newValue }
    }
    
}

extension Int {
    
    var decimalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: self as NSNumber) ?? "\(self)"
    }
    
}

extension UIViewController {
    
    func showAlert(title: String, message:String = "", actions: [UIAlertAction] = [UIAlertAction(title: "확인", style: .cancel)] ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach { alert.addAction($0) }
        
        present(alert, animated: true)
        
    }
    
}

extension String {
    
    func attributed(color: UIColor? = nil) -> NSMutableAttributedString {
        if let color = color {
            return NSMutableAttributedString(string: self, attributes: [.foregroundColor : color])
        }
        return NSMutableAttributedString(string: self)
    }
    
}

extension NSMutableAttributedString {
    
    func combine(to attr: NSMutableAttributedString) -> NSMutableAttributedString {
        let new = NSMutableAttributedString(string: "")
        new.append(self)
        new.append(attr)
        return new
    }
    
}
