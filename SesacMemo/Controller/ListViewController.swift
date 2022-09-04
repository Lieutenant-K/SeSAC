//
//  BaseViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit

class ListViewController: BaseViewController {

    final let listView = ListView()
    
    let listCellIdentifier = "cell"
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setListTableView()
    }
    
    private func setListTableView() {
        listView.tableView.keyboardDismissMode = .onDrag
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.register(ListCell.self, forCellReuseIdentifier: listCellIdentifier)
        
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    
}
