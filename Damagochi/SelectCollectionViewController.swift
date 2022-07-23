//
//  SelectCollectionViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit


class SelectCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .init(named: "Background")
        
        let layout = UICollectionViewFlowLayout()
        let spacing = 15.0
        let width = floor((UIScreen.main.bounds.width - 4*spacing) / 3)
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = .init(width: width, height: width*1.2)
        
        collectionView.collectionViewLayout = layout
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DamagochiCollectionCell.identifier, for: indexPath) as? DamagochiCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.configurateCell()
//        cell.imageView.backgroundColor = .green
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }


}
