//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacing: Double = 20
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 2*spacing, height: collectionView.bounds.height - 4*spacing)
        print(collectionView.bounds.height)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: BeerCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: BeerCollectionViewCell.reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemGray6
        
    }
    
    func request(cell: BeerCollectionViewCell){
        
        let url = EndPoint.beerURL
        AF.request(url).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value).arrayValue[0]
                print(json)
                cell.nameLabel.text = json["name"].stringValue
                cell.descriptionLabel.text = json["description"].stringValue
                
                let url = URL(string: json["image_url"].stringValue)
                cell.imageView.kf.setImage(with: url)
                
            case .failure(let error):
                print(error)
            }
        }
    
    }
    
    
}

extension BeerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.reuseIdentifier, for: indexPath) as! BeerCollectionViewCell
        
        cell.configurateCell()
        request(cell: cell)
        
        return cell
    }
}
