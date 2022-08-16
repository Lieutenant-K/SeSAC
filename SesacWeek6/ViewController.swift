//
//  ViewController.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON

/*
<b> </b>
1. html 태그 사용
2. 문자열 대체 메서드 (replacingOccurences)
 */

/*
 
 - 컨텐츠 양에 따라서 셀 높이가 자유롭게 변경된다.
 - 조건 : label의 numberoflines가 0
 - 조건 : tableView의 높이를 automaticDimension
 - 조건 : 내부 컨텐츠의 레이아웃 설정
 
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var blogList = [String]()
    var cafeList = [String]()
    
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBlog()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func searchBlog() {
        
        APIManager.shared.callRequest(type: .blog, query: "카리나") { json in
            
            print(json)
            
            for item in json["documents"].arrayValue {
                
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                
                self.blogList.append(value)
            }
            
            self.searchCafe()

        }
        
    }
    
    func searchCafe() {
        
        APIManager.shared.callRequest(type: .cafe, query: "카리나") { json in
            
            print(json)
            
            for item in json["documents"].arrayValue {
                self.cafeList.append(item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: ""))
            }
            
//            print(self.blogList)
//            print(self.cafeList)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    @IBAction func expendCell(_ sender: UIBarButtonItem) {
        
        isExpanded.toggle()
        tableView.reloadData()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KakaoCell", for: indexPath) as? KakaoCell else { return UITableViewCell()}
        cell.label.numberOfLines = isExpanded ? 0 : 2
        cell.label.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색결과" : "카페 검색결과"
    }
    
}

class KakaoCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    
}
