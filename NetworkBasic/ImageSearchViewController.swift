//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class ImageSearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var searchList:[ImageSearchData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacing: Double = 20
        let width = UIScreen.main.bounds.width - 3*spacing
        let height = collectionView.bounds.height - 3*spacing
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width/2 , height: height/2)
        
//        print(collectionView.bounds.height)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.backgroundColor = .systemGray6
        
        

        fetchImage(text: "에스파")
    }
    
    
    func fetchImage(text: String) {
        
        guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        // 쿼리 스트링으로 파라미터 전달
        let url = EndPoint.iamgeSearchURL + "query=\(text)&display=100&start=1&sort=sim"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER, "X-Naver-Client-Secret": APIKey.NAVERKEY]
        
//        let parameters: Parameters = ["query":"apple" , "display": 30, "sort":"sim" ]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print(json)
                
                for item in json["items"].arrayValue {
                    self.searchList.append(ImageSearchData(title: item["title"].stringValue, link: item["link"].stringValue))
                }
                
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchImageCell.reuseIdentifier, for: indexPath) as! SearchImageCell
        
        cell.configurateContent(data: searchList[indexPath.row])
        
        return cell
    }
}
