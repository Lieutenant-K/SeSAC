//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {

    var wholeSettingData = ["공지사항", "실험실", "버전 정보"]
    var indivisualSettingData = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var otherData = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 1. 셀의 갯수(필수)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return wholeSettingData.count
        } else if section == 1 {
            return indivisualSettingData.count
        } else if section == 2 {
            return otherData.count
        } else {
            return 0
        }
    }
    
    // 2. 셀의 디자인과 데이터(필수)
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        var text = ""
        
        if indexPath.section == 0 {
            text = wholeSettingData[indexPath.row]
        } else if indexPath.section == 1 {
            text = indivisualSettingData[indexPath.row]
        } else if indexPath.section == 2 {
            text = otherData[indexPath.row]
        }
        
        cell.textLabel?.text = text
//        cell.textLabel?.textColor = .systemMint
//        cell.textLabel?.font = .systemFont(ofSize: 18)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else if section == 2 {
            return "기타"
        } else {
            return "세션"
        }
    }
    

}
