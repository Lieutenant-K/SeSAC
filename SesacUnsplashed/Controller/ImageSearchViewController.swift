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
    
    var delegate: ImageSendable?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectPhoto))
        
    }
    
    @objc func selectPhoto() {
        
        guard let index = searchView.collectionView.indexPathsForSelectedItems?.first else { return }
        
        guard let url = URL(string: photos[index.row].full) else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result{
            case .success(let value):
                self.delegate?.sendImageData(image: value.image)
            case .failure(let error):
                print(error)
            }
        }
        
//        delegate?.sendImageData(image: cell.imageView.image)
       
        
//        NotificationCenter.default.post(name: .sendImageURLNotification, object: nil, userInfo: ["imageURL": photos[index.row].full])
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func resetPhotoData() {
        
        photos.removeAll()
        
        page = 1
        
        totalResult = 0
        
    }

}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.setImage(url: photos[indexPath.row].thumb)
        
        return cell
        
    }
    
    
    
    
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        resetPhotoData()
        
        let para = Parameter(page: page, query: text, itemsPerPage: 20).paramter
        
        APIManager.shared.fetchPhotosWithQuery(parameter: para) { total, data in
            
            self.totalResult = total
            
            self.photos.append(contentsOf: data)
            
            DispatchQueue.main.async {
                
                self.searchView.collectionView.reloadData()
                
            }
        }
        
        searchBar.endEditing(true)
        
    }
    
    
}
