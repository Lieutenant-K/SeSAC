//
//  SearchView.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

import SnapKit

class SearchView: BaseView {

    let searchBar:UISearchBar = {
       let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
//        view.backgroundColor = .lightGray

        
        return view
    }()
    
    override func setSubviews() {
        
        [searchBar, collectionView].forEach { addSubview($0) }
        
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
    }
    
    func setCollectionViewLayoutItemSize(width: CGFloat) {
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        layout.itemSize = CGSize(width: width/3, height: width/3)
        
    }
    
    override func layoutSubviews() {
        
        setCollectionViewLayoutItemSize(width: bounds.width)
        
        super.layoutSubviews()
    }
}
