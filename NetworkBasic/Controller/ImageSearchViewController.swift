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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var searchList:[ImageSearchData] = []
    
    // 검색 시작 페이지
    var startPage = 1
    var displayCount = 10
    var total = 0
    var isDataLoading = false
    var currentWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configurateCollectionView()

//        fetchImage()
    }
    
    func configurateCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        let spacing: Double = 20
        let width = (UIScreen.main.bounds.width - 2*spacing)
        let height = collectionView.bounds.height - 3*spacing
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width , height: width)
        
//        print(collectionView.bounds.height)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.prefetchDataSource = self
        
    }
    
    
    func fetchImage(query: String) {
        
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage, displayCount: displayCount) { total, list in
            
            self.total = total
            self.searchList.append(contentsOf: list)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
    }
    
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("===cellForItemAt", indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchImageCell.reuseIdentifier, for: indexPath) as! SearchImageCell
        
        cell.configurateContent(data: searchList[indexPath.row])
        
        return cell
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("itemWillDisplay", indexPath)
        if indexPath.item == searchList.count - 1 {
            startPage += displayCount
            fetchImage(text: currentWord)
        }
    }*/
    
    /*
    // 페이지네이션 방법 1
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인이 어려움.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        <#code#>
    }
     */
    
    
    // 페이지네이션 방법 2
    // 테이블, 컬렉션 뷰는 스크롤뷰를 상속받기 때문에 스크롤뷰 프로토콜 사용 가능
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentSize.height, scrollView.contentOffset.y, scrollView.visibleSize.height)
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.visibleSize.height - 20 && searchList.count < total && !isDataLoading {

            isDataLoading = true
            startPage += displayCount
            fetchImage(text: currentWord)
        }
    }
    */
    
    
}


// 페이지네이션 방법 3 용량이 큰 이미지를 다운로드해서 셀에 보여줄때 효과적
// 셀이 화면에 보이기 전에 필요한 리소스를 다운로드 받고, 필요하지 않으면 취소할 수도 있음.
// iOS 10 이상 지원, 스크롤 성능 향상됨.

extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 다운로드
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for index in indexPaths {
            
            if searchList.count-1 == index.item && searchList.count < total {
                startPage += displayCount
                fetchImage(query: currentWord)
            }
            
        }
        
        
        print("====\(indexPaths)")
    }
    
    // 취소
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소 ====\(indexPaths)")
    }
    
    
    
    
}


extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchList.removeAll()
            collectionView.reloadData()
            startPage = 1
            currentWord = text
//            collectionView.scrollToItem(at: [0, 0], at: .top, animated: false)
            fetchImage(query: text)
            self.view.endEditing(true)
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        collectionView.reloadData()
        startPage = 1
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false , animated: true)
    }
    
}

