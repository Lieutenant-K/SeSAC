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
    
    enum Section: String, CaseIterable {
        case cast = "Cast"
        case crew = "Crew"
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerBackdropImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerPosterImageView: UIImageView!
    
    let movieInfo: MovieInfo
    let progressHud = JGProgressHUD()
    let backdropImageRatio = 497.0 / 885.0
    
    var infoList = [[DisplayInCell]]()
    
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
        progressHud.show(in: self.view, animated: false)
        APIManager.shared.fetchCreditDetails(genre: .movie, id:movieInfo.id) { list in
            self.infoList = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.progressHud.dismiss(animated: false)
            }
            
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
        
        let info = infoList[indexPath.section][indexPath.row]
        
        cell.configurateCell(title: info.titleText, subTitle: info.subText, profilePath: info.imagePath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoList[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    
}
