//
//  CreditViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/04.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import JGProgressHUD

class CreditViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerBackdropImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerPosterImageView: UIImageView!
    
    let movieInfo: MovieInfo
    let progressHud = JGProgressHUD()
    let backdropImageRatio = 497.0 / 885.0
    var castList: [CastInfo] = []
    var crewList: [CrewInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연 및 제작"
        
        tableView.rowHeight = 120
        tableView.tableHeaderView?.frame.size.height = UIScreen.main.bounds.width * backdropImageRatio
        tableView.delegate = self
        tableView.dataSource = self
        
        
        configurateHeaderView()
        
        fetchCreditList()
        
    }
    
    func configurateHeaderView() {
        
        headerTitleLabel.text = movieInfo.title
        
        headerBackdropImageView.kf.setImage(with: URL(string: EndPoint.image(.backdrop(.original), movieInfo.backdropPath).url))

        headerPosterImageView.kf.setImage(with: URL(string: EndPoint.image(.poster(.w185), movieInfo.postPath).url))
        
    }
    
    func fetchCreditList() {
        
        let url = EndPoint.credit(.movie, movieInfo.id).url
        
        requestData(url: url) { jsonData in
            
            for item in jsonData["cast"].arrayValue {
                
                let info = CastInfo(name:item["name"].stringValue,
                                    department: item["known_for_department"].stringValue,
                                    character: item["character"].stringValue,
                                    profilePath: item["profile_path"].stringValue
                )
                
                self.castList.append(info)
            }
            
            for item in jsonData["crew"].arrayValue {
                
                let info = CrewInfo(name:item["name"].stringValue,
                                    department: item["department"].stringValue,
                                    job: item["job"].stringValue,
                                    profilePath: item["profile_path"].stringValue
                )
                
                self.crewList.append(info)
            }
            
            self.tableView.reloadData()
        }
        
        
    }
    
    
    func requestData(url: String, completionHandler: @escaping (_ jsonData : JSON) -> Void) {
        
        // 쿼리 스트링으로 파라미터 전달
        let url = url + "?api_key=\(APIKey.movieKey)"
        
        progressHud.show(in: self.view, animated: true)
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                completionHandler(json)
                
                
            case .failure(let error):
                print(error)
            }
            self.progressHud.dismiss(animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init?(coder: NSCoder, info: MovieInfo) {
        movieInfo = info
        super.init(coder: coder)
    }
    
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditCell.reuseIdentifier, for: indexPath) as! CreditCell
        
        switch indexPath.section {
        case 0:
            cell.configurateCell(title: castList[indexPath.row].titleText, subTitle: castList[indexPath.row].subText, profilePath: castList[indexPath.row].profilePath)
            
        case 1:
            cell.configurateCell(title: crewList[indexPath.row].titleText, subTitle: crewList[indexPath.row].subText, profilePath: crewList[indexPath.row].profilePath)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return castList.count
        case 1:
            return crewList.count
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Cast"
        case 1:
            return "Crew"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    
}
