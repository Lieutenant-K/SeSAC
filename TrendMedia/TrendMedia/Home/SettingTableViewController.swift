//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/18.
//

import UIKit

// CaseIterable: 프로토콜, 배열처럼 열거형을 사용할 수 있는 특징이 있음
enum SettingOptions: Int, CaseIterable {
    case total, personal, others
    
    var sectionTitle: String {
        
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
        
    }
    
    var rowTitle: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 1. 셀의 갯수(필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SettingOptions.allCases[section].rowTitle.count
        
        
    }
    
    // 2. 셀의 디자인과 데이터(필수)
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
    
//        cell.textLabel?.textColor = .systemMint
//        cell.textLabel?.font = .systemFont(ofSize: 18)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return SettingOptions.allCases[section].sectionTitle
    }

}
