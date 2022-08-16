//
//  MainViewController.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/09.
//

import UIKit

import Kingfisher
/*
 
 
 
 */
class MainViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let numberList: [[Int]] = [
        [Int](100...109),
        [Int](150...155),
        [Int](200...204),
        [Int](505...512),
        [Int](42...46),
        [Int](10...50),
        [Int](505...512),
        [Int](42...46),
        [Int](10...50),
        
    ]
    
    var episodeList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
        bannerCollectionView.isPagingEnabled = true
        
        TMDBAPIManager.shared.requestImage { posterList in
            dump(posterList)
            self.episodeList = posterList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
      
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("MainViewController", #function, indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell()}
        
        if collectionView == bannerCollectionView {
            
            let color: [UIColor] = [.systemPink, .blue, .cyan, .orange, .red]
            
            cell.cardView.imageView.backgroundColor = color[indexPath.row]
            
        } else {
            
//            cell.cardView.label.text = String(numberList[collectionView.tag][indexPath.row])
            let url = URL(string: "\(TMDBAPIManager.shared.imageURL)\(episodeList[collectionView.tag][indexPath.row])")
            cell.cardView.imageView.kf.setImage(with: url)
            cell.cardView.label.textColor = .white
            cell.cardView.imageView.backgroundColor = .black
        }
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == bannerCollectionView ? 5 : episodeList[collectionView.tag].count
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bannerCollectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        episodeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("MainViewController", #function, indexPath)
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        cell.backgroundColor = .yellow
        cell.label.text = TMDBAPIManager.shared.tvList[indexPath.section].0
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
}

