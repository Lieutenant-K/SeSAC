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
    let viewModel = SearchViewModel(photo: Observable(value: []), itemCount: 10)
    var delegate: ImageSendable?
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        viewModel.photo.bind { [unowned self] in
            var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
            snapshot.appendSections([0])
            snapshot.appendItems(viewModel.photo.value)
            dataSource.apply(snapshot)
        }
        
        searchView.searchBar.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectPhoto))
        
    }
    
    func configureCollectionView() {
        
        searchView.collectionView.delegate = self
//        searchView.collectionView.prefetchDataSource = self
        
        let cellRegistration = UICollectionView.CellRegistration<ImageCollectionViewCell, PhotoResult>  { cell, indexPath, itemIdentifier in
            
            
            let url = itemIdentifier.urls.thumb
            cell.imageView.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.5))])
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: searchView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
            
        })
        
        
    }
    
    @objc func selectPhoto() {
        
        guard let index = searchView.collectionView.indexPathsForSelectedItems?.first else { return }
        
        viewModel.sendImageURL(indexPath: index)
    
        /*
        KingfisherManager.shared.retrieveImage(with: URL(string: url)!) { result in
            switch result{
            case .success(let value):
                self.delegate?.sendImageData(image: value.image)
            case .failure(let error):
                print(error)
            }
        }
        */
//        delegate?.sendImageData(image: cell.imageView.image)
       
        
//        NotificationCenter.default.post(name: .sendImageURLNotification, object: nil, userInfo: ["imageURL": photos[index.row].full])
        
        self.navigationController?.popViewController(animated: true)
        
        
    }

}

extension ImageSearchViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        viewModel.updatePage(indexPath: indexPath)
        
    }
    
    
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        viewModel.query = text
        
        searchBar.endEditing(true)
        
    }
    
    
}
