//
//  CardViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/10.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardSectionTableView: UITableView!
    
    let cardSection = [
        [Int](1...100),
        [Int](5...50),
        [Int](12...34),
        [Int](45...97)
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardSectionTableView.delegate = self
        cardSectionTableView.dataSource = self
        
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
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }
    
}

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as! CardCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cardSection[collectionView.tag].count
    }
    
}
