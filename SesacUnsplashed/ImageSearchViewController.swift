//
//  ImageSearchViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

import Kingfisher

class ImageSearchViewController: UIViewController {
    
    let searchView = SearchView()
    
    var photos = [ImageURL]()
    
    var page = 1
    
    var totalResult = 0
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.searchBar.delegate = self
        
    }

}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
        
    }
    
    
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        APIManager.shared.fetchPhotosWithQuery(query: text, page: page, amountOfResultForPage: 20) { total, data in
            
            self.totalResult = total
            
            self.photos.append(contentsOf: data)
            
            DispatchQueue.main.async {
                
                self.searchView.collectionView.reloadData()
                
            }
            
            
        }
        
    }
    
    
}
