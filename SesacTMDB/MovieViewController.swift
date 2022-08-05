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
import JGProgressHUD

class MovieViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let progressHud = JGProgressHUD()
    var currentPage = 1
    var totalResult = 0
    var genreDictionary = [Int: String]()
    var movieList: [MovieInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
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
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
    }
    
    func fetchGenreList() {
        
        APIManager.shared.fetchGenreDictionary(media: .movie) { dict in
            self.genreDictionary.merge(dict) { (current, _ ) in current }
        }
        
//        APIManager.shared.fetchGenreDictionary(media: .tv) { dict in
//            self.genreDictionary.merge(dict) { (current, _ ) in current }
//        }
        
    }
    
    func fetchMovieList() {
        
        progressHud.show(in: self.view, animated: false)
        APIManager.shared.fetchTrendingItems(timeWindow: .day, page: currentPage) { total, movieList in
            
            self.totalResult = total
            self.movieList.append(contentsOf: movieList)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.progressHud.dismiss(animated: false)
            }
        }
        
    }
    /*
    func requestData(url: String, parameter: Parameters? = nil, completionHandler: @escaping (_ jsonData : JSON) -> Void) {
        
        // 쿼리 스트링으로 파라미터 전달
        let url = url + "?api_key=\(APIKey.movieKey)"
        
        progressHud.show(in: self.view, animated: true)
        
        AF.request(url, method: .get, parameters: parameter).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print(json)
                
                completionHandler(json)
                
                
            case .failure(let error):
                print(error)
            }
            self.progressHud.dismiss(animated: false)
        }
    }
    */
    
}


extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        cell.configurateCell(movieInfo: movieList[indexPath.row], genreDict: genreDictionary)
        
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


extension MovieViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for index in indexPaths {
            
            if index.item == movieList.count-1 && movieList.count < totalResult {
                
                currentPage += 1
                fetchMovieList()
                
                
            }
        }
    }
}
