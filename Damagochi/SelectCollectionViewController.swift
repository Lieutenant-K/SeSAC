//
//  SelectCollectionViewController.swift
//  Damagochi
//
//  Created by 김윤수 on 2022/07/23.
//

import UIKit


class SelectCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    static let identifier = "SelectCollectionViewController"
    
    
    // MARK: - Method
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = MyDamagochi.shared.type == .none ? "다마고치 선택하기" : "다마고치 변경하기"
        view.backgroundColor = TintColor.background
        view.tintColor = TintColor.foreground
        
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
    
    
    // MARK: CollectionView Method
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DamagochiCollectionCell.identifier, for: indexPath) as? DamagochiCollectionCell else {
            return UICollectionViewCell()
        }
        
        let type: DamagochiType = indexPath.row < DamagochiType.allCases.count ? DamagochiType.allCases[indexPath.row] : .none
        
        cell.configurateCell(type: type)
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 20 }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? DamagochiCollectionCell, cell.damagochiType != .none else { return false }
        
        return true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailPopUpViewController.identifier) as! DetailPopUpViewController
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.type = DamagochiType.allCases[indexPath.row]
        
        present(vc, animated: true)
        
    }

}
