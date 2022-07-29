//
//  LocationViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {

    // 1. Notification, UN = UserNotification, 유저 알림을 관리하는 객체
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for family in UIFont.familyNames {
            print("=====\(family)=====")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
//        requestAuthorization()
    }
    
    @IBAction func touchNotificationButton(_ sender: UIButton) {
        
        requestAuthorization()
        
    }
    // 2. 알림 권한 요청
    func requestAuthorization() {
        
        let options = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: options) { success, error in
            if success {
                self.sendNotifiaction()
            }
        }
        
    }
    
    // 권한을 허용한 유저에게 알림 요청(언제 어떤 컨텐츠의 알림을 보낼 것인지)
    
    /*
     1. 뱃지 제거
     2. 알림 제거
     3. 포그라운드 상태에서 알림 수신
    
     */
    
    func sendNotifiaction() {
            
        // 알림 컨텐츠(내용)
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "이것이 알림이다"
        notificationContent.body = "이것은 바디입니다."
        notificationContent.badge = 40
        notificationContent.subtitle = "\(Int.random(in: 1...100))"
        
        // 알림 시기
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        /*
        var dateComponent = DateComponents()
        dateComponent.minute = 15
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        */
        
        // 알림을 관리할 필요성이 있으면 의미있는 identifier를 사용함
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
        
        
    }
    

}

