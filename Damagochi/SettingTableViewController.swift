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

        nicknameLabel.text = MyDamagochi.shared.userNickname
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
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SelectCollectionViewController.identifier) as! SelectCollectionViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let alertController = UIAlertController(title: "데이터 초기화", message: "불쌍한 다마고치를 버리시겠어요?", preferredStyle: .alert)
            
            alertController.addAction(.init(title: "그럴 순 없어", style: .cancel))
            
            alertController.addAction(.init(title: "다시 키울래요", style: .destructive, handler: { _ in
                let myDamagochi =  MyDamagochi.shared
                myDamagochi.type = .none
                myDamagochi.water = 0
                myDamagochi.rice = 0
                myDamagochi.userNickname = "대장"
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SelectCollectionViewController.identifier) as! SelectCollectionViewController
                
                let navi = UINavigationController(rootViewController: vc)
                
                navi.modalPresentationStyle = .fullScreen
                navi.modalTransitionStyle = .crossDissolve
                
                self.present(navi, animated: true)
                
            }))
            
            present(alertController, animated: true)
            
        default:
            return
            
        }
        
        
    }
    
    deinit {
        print("세팅 뷰 메모리 헤제")
    }
}
