//
//  BaseViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit

class ListViewController: UIViewController {

    let listView = ListView()
    
    let listCellIdentifier = "cell"
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setListTableView()
        setNavigationItem()
        setToolBarItem()
    }
    
    private func setListTableView() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.register(ListCell.self, forCellReuseIdentifier: listCellIdentifier)
        
    }
    
    func setNavigationItem() {}
    
    func setToolBarItem() {}

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        
        cell.mainLabel.text = "메인 레이블 테스트"
        cell.subLabel.text = "서브 레이블 테스트"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.numberOfLines = 1
        view.text = "섹션 테스트"
        view.textColor = .label
        view.font = .systemFont(ofSize: 28, weight: .semibold)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    
}
