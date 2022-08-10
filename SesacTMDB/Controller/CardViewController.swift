//
//  CardViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/10.
//

import UIKit

import Kingfisher

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardSectionTableView: UITableView!
    
    let movieTitle = ["Prey", "Elvis", "The Gray Man", "Minions: The Rise of Gru", "Resurrection"]
    
    var cardSection = [[MovieInfo]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardSectionTableView.delegate = self
        cardSectionTableView.dataSource = self
        
        fetchCardSection()
        
    }
    

    func fetchCardSection() {
        
        var datas = [[MovieInfo]]()
        APIManager.shared.fetchRecommandations(genre: .movie, id: 766507, page: 1) { data in
            datas.append(data)
            APIManager.shared.fetchRecommandations(genre: .movie, id: 614934, page: 1) { data in
                datas.append(data)
                APIManager.shared.fetchRecommandations(genre: .movie, id: 725201, page: 1) { data in
                    datas.append(data)
                    APIManager.shared.fetchRecommandations(genre: .movie, id: 438148, page: 1) { data in
                        datas.append(data)
                        APIManager.shared.fetchRecommandations(genre: .movie, id: 872497, page: 1) { data in
                            datas.append(data)
                            self.cardSection = datas
//                            print(self.cardSection)
                            DispatchQueue.main.async {
                                self.cardSectionTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
        
    }
}

extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        cardSection.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CardSectionCell.reuseIdentifier, for: indexPath) as! CardSectionCell
        
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.register(.init(nibName: CardCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        cell.contentCollectionView.tag = indexPath.section
        cell.titleLabel.text = movieTitle[indexPath.section] + "와 유사한 영화"
        cell.contentCollectionView.reloadData()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
}

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as! CardCell
        
        let info = cardSection[collectionView.tag][indexPath.row]
        
        cell.configurateCell(info: info)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cardSection[collectionView.tag].count
    }
    
}
