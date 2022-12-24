//
//  Extension.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/10/13.
//

import UIKit

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

extension Date {
    
    var dateString: String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        let calendar = Calendar(identifier: .iso8601)
        
        let now = Date()
        let firstDayOfWeek = calendar.dateComponents([.calendar, .weekOfYear, .yearForWeekOfYear], from: now).date!
        
        if self >= calendar.startOfDay(for: now) {
            
            formatter.dateFormat = "a hh:mm"
            
            return formatter.string(from: self)
            
        } else if self >= firstDayOfWeek {
            
            let weekday = calendar.dateComponents([.weekday], from: self).weekday!
            
            return formatter.weekdaySymbols[weekday-1]
            
        } else {
            
            formatter.dateFormat = "yyyy. MM. dd a hh:mm"
            
            return formatter.string(from: self)
        }
        
        
    }
    
    
}
