//
//  SettingTableViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/24.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var nicknameLabel: UILabel!
    
    static let identifier = "SettingTableViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "설정"
//        tableView.sectionHeaderHeight = 0
        tableView.sectionHeaderTopPadding = 0
        view.backgroundColor = TintColor.background
        view.tintColor = TintColor.foreground

        nicknameLabel.text = "나의 이름은 무엇?"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ChangeNameViewController.identifier) as! ChangeNameViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            print("다마고치 변경하기")
            
        case 2:
            print("데이터 초기화")
            
        default:
            return
            
        }
        
        
    }
}
