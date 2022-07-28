//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/27.
//

import UIKit
/*
Protocol
 - Delegate
 - DataSource
 */



class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = "안녕하세요"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰가 해야할 역할을 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: Xml Interface Builder
        
        searchTableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    
    

}
