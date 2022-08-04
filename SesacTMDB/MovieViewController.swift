//
//  ViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class MovieViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var genreList = [Int: String]()
    var movieList: [MovieInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateCollectionView()
        fetchGenreList()
        fetchMovieList()
        
    }
    
    func configurateCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: Double = 20
        let width = UIScreen.main.bounds.width - 2*spacing
//        let height = width*0.8
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width , height: width)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing+10
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func fetchGenreList() {
        
        var url = EndPoint.genre(Genres.tv).url
        
        requestData(url: url) { data in
            for genre in data["genres"].arrayValue {
                self.genreList[genre["id"].intValue] = genre["name"].stringValue
            }
        }
        
        url = EndPoint.genre(Genres.movie).url
        
        requestData(url: url) { data in
            for genre in data["genres"].arrayValue {
                self.genreList[genre["id"].intValue] = genre["name"].stringValue
            }
        }
        
    }
    
    func fetchMovieList() {
        
        let url = EndPoint.trending(.movie, .week).url
        
        requestData(url: url) { jsonData in
            
            for item in jsonData["results"].arrayValue {
                
                
                let info = MovieInfo(id:item["id"].intValue,
                                     title: item["title"].stringValue,
                                     postPath: item["poster_path"].stringValue,
                                     backdropPath: item["backdrop_path"].stringValue,
                                     releaseDate: item["release_date"].stringValue,
                                     overview: item["overview"].stringValue,
                                     genre: item["genre_ids"].arrayValue.map { element in
                    "#"+(self.genreList[element.intValue] ?? "No Genre")
                })
                
                self.movieList.append(info)
                
            }
            self.collectionView.reloadData()
        }
        
        
    }
    
    func requestData(url: String, completionHandler: @escaping (_ jsonData : JSON) -> Void) {
        
        // 쿼리 스트링으로 파라미터 전달
        let url = url + "?api_key=\(APIKey.movieKey)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print(json)
                
                completionHandler(json)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        cell.configurateCell(movieInfo: movieList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: CreditViewController.reuseIdentifier, creator: { coder in
            
            let vc = CreditViewController(coder: coder, info: self.movieList[indexPath.row])
            
            return vc
            
        })
                
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

