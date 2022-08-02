//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON


class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
   
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
        
        let date = formatter.string(from: Date().addingTimeInterval(-24*60*60))
        
        requestBoxOffice(text: date)
    }
    
    /*
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
     */
    
    func requestBoxOffice(text: String) {
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print(json)
                
                self.list.removeAll()
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    self.list.append(BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc))
                }
                
                self.searchTableView.reloadData()
//                print(self.list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        
        cell.configurateContent(data: list[indexPath.row])
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!)
    }
    
    
}
