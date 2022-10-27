//
//  BaseViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit

class ListViewController: BaseViewController {

    final let listView = ListView()
    
    final let listCellIdentifier = "cell"
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setListCollectionView()
    }
    
    func setListCollectionView() {
        listView.collectionView.keyboardDismissMode = .onDrag
//        listView.collectionView.delegate = self
//        listView.collectionView.dataSource = self
        
    }

}

