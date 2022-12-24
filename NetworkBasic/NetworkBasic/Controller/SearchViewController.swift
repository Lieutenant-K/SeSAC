//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON
import JGProgressHUD
import RealmSwift


class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let hud = JGProgressHUD()
    
    let localRealm = try! Realm()
    
    //BoxOffice 배열
    var list: List<MovieData>?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // 테이블뷰가 해야할 역할을 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.rowHeight = 100
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: Xml Interface Builder
        
        searchTableView.register(UINib(nibName: SearchTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        // Calander 사용하기
        let yesterday = formatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        
        // TimeInterval 사용하기
        let date = formatter.string(from: Date().addingTimeInterval(-24*60*60))
        
        print(localRealm.configuration.fileURL)
        
        checkSearchRecord(text: yesterday)
    }
    
    /*
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
     */
    
    func checkSearchRecord(text: String) {
        
        if let object = localRealm.objects(SearchRecord.self).first(where: { $0.dateString == text }) {
            print(#function)
            
            list = object.movieData
            
            searchTableView.reloadData()
            
            return
        }
        
        requestBoxOffice(text: text)
        
    }
    
    func requestBoxOffice(text: String) {
        
        hud.show(in: self.view, animated: true)
        
//        self.list?.removeAll()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print(json)
                
                let data = List<MovieData>()
                
                json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue.forEach { movie -> Void in
                    
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    data.append(MovieData(title: movieNm, date: openDt, total: audiAcc))
                }
                
                // 데이터 없으면 저장하지 않음
                if data.isEmpty {
                    self.hud.dismiss(animated: true)
                    return
                }
                
                let task = SearchRecord(date: text, data: data)
                try! self.localRealm.write {
                    self.localRealm.add(task)
                }
                
                self.list = self.localRealm.objects(SearchRecord.self).first { $0.dateString == text }?.movieData
                
                self.searchTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
            self.hud.dismiss(animated: true)
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        if let data = list?[indexPath.row] {
            
            cell.configurateContent(data: data)
            
        }
        
        
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        guard let _ = formatter.date(from: searchBar.text ?? "") else { return }
        
        checkSearchRecord(text: searchBar.text!)
    }
    
    
}
