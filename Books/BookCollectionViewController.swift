//
//  BookCollectionViewController.swift
//  Books
//
//  Created by 김윤수 on 2022/07/20.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {
    
    var bookList = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = (UIScreen.main.bounds.width - 3*spacing)/2
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width)
        
        collectionView.collectionViewLayout = layout
        
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        
        cell.cellConfiguration(book: bookList.movie[indexPath.row])
        
        
        return cell
    }

}
