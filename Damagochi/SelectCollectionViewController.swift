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
        
        self.title = "다마고치 선택하기"
        view.backgroundColor = TintColor.background
        
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
        
        if indexPath.row < DamagochiType.allCases.count {
            cell.configurateCell(type: DamagochiType.allCases[indexPath.row])
        } else {
            cell.configurateCell(type: .none)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 열거형의 마지막 케이스가 유효하지 않다는 보장이 있어야함.
        if indexPath.row >= DamagochiType.allCases.endIndex-1 {
            return
        }
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailPopUpViewController.identifier) as! DetailPopUpViewController
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.type = DamagochiType.allCases[indexPath.row]
        
        present(vc, animated: true)
    }


}
