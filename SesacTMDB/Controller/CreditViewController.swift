//
//  CreditViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/04.
//

import UIKit

import Kingfisher
import JGProgressHUD
import TMDBFramework

class CreditViewController: UIViewController {
    
    enum Section: String, CaseIterable {
        case overview = "Overview"
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
    
    var crewList = [CrewInfo]()
    var castList = [CastInfo]()
//    var infoList = [[DisplayInCell]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연 및 제작"
        
        configurateTableView()
        
        configurateHeaderView()
        
        fetchCreditList()
        
    }
    
    private func configurateTableView() {
        
        tableView.tableHeaderView?.frame.size.height = UIScreen.main.bounds.width * backdropImageRatio
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: InfoListCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: InfoListCell.reuseIdentifier)
        tableView.register(.init(nibName: ExpandableCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ExpandableCell.reuseIdentifier)
        
    }
    
    private func configurateHeaderView() {
        
        headerTitleLabel.text = movieInfo.title
        
        headerBackdropImageView.kf.setImage(with: URL(string: EndPoint.image(.backdrop(.original), movieInfo.backdropPath).url))

        headerPosterImageView.kf.setImage(with: URL(string: EndPoint.image(.poster(.w185), movieInfo.postPath).url))
        
    }
    
    func fetchCreditList() {
        progressHud.show(in: self.view, animated: false)
        APIManager.shared.fetchCreditDetails(genre: .movie, id:movieInfo.id) { cast, crew in
            self.castList = cast
            self.crewList = crew
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
        
        let section = Section.allCases[indexPath.section]
        
        switch section {
            
        case .overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.reuseIdentifier, for: indexPath) as! ExpandableCell
            
            cell.label.text = movieInfo.overview
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoListCell.reuseIdentifier, for: indexPath) as! InfoListCell
            
            let info: DisplayInCell = section == .cast ? castList[indexPath.row] : crewList[indexPath.row]
            
            cell.configurateCell(title: info.titleText, subTitle: info.subText, profilePath: info.imagePath)
            
            return cell
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .overview:
            return 1
        case .cast:
            return castList.count
        case .crew:
            return crewList.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        Section.allCases[indexPath.section] == .overview ? UITableView.automaticDimension : 120
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ExpandableCell{
            cell.isExpanded.toggle()
            tableView.reloadData()
            // 아래 메서드는 제대로 동작하지 않음.
//            tableView.reloadSections([indexPath.section], with: .automatic)
//            tableView.deselectRow(at: indexPath, animated: true)
//            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
}
