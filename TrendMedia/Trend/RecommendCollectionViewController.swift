//
//  RecommendCollectionViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher

private let reuseIdentifier = "Cell"
/*
 Table -> Collection
 Row -> Item
 heightForRowAt -> FlowLayout (heightForItemAt 이 없는 이유 )
 */

class RecommendCollectionViewController: UICollectionViewController {
    
    var image = "https://images.unsplash.com/photo-1499209974431-9dddcece7f88?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션뷰의 셀 크기, 샐 사이 간격 등
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing*4
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width/3, height: 1.2*width/3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as! RecommendCollectionViewCell
        
        cell.posterImageView.backgroundColor = .orange
        
        let url = URL(string: image)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        view.makeToast("\(indexPath)")
        view.makeToast("\(indexPath)", duration: 1, position: .center)
    
    }
    
    


}
