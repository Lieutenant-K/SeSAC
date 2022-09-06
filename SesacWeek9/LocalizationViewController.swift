//
//  LocalizationViewController.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/09/06.
//

import UIKit
import CoreLocation
import MessageUI

class LocalizationViewController: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = NSLocalizedString("navigation_title", comment: "네비게이션 바에 나타나는 타이틀")
        
        let placehodler = NSLocalizedString("search_placeholder", comment: "검색 바의 플레이스홀더")
        
        let cancel = NSLocalizedString("common_cancel", comment: "취소 타이틀")
        
        searchBar.placeholder = placehodler
        button.setTitle(cancel, for: .normal)
        label.text = "introduce".localized(with: "김윤수")
        textview.text = String(format: "number_test".localized, 27)
        
        CLLocationManager().requestWhenInUseAuthorization()
        
    }
    
    func sendMail() {
        
        if MFMailComposeViewController.canSendMail(){
            
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["rodxxx@naver.com"])
            mail.setSubject("문희사항")
            mail.mailComposeDelegate = self
            
            self.present(mail, animated: true)
            
        } else {
            // 메일을 보낼 수 없음
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            <#code#>
        case .saved:
            <#code#>
        case .sent:
            <#code#>
        case .failed:
            <#code#>
        }
    }
 

}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized<T:CVarArg>(with: T) -> String {
        return String(format: self.localized, with)
    }
    
}
