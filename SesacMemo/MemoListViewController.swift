//
//  MemoListViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import RealmSwift

class MemoListViewController: ListViewController {

    let repository = MemoRealmRepository()
    
    var memos: Results<Memo>! {
        didSet {
            
            title = "\(memos.count)개의 메모"
            listView.tableView.reloadData()
            
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMemoData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        self.navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchMemoData()
    }
    
    // MARK: - Method
    
    override func setNavigationItem() {
        
        title = "메모"
        
        let naviItem = self.navigationItem
        
        naviItem.searchController = UISearchController(searchResultsController: nil)
        naviItem.searchController?.searchBar.placeholder = "검색"
        naviItem.hidesSearchBarWhenScrolling = false
        naviItem.backButtonTitle = "메모"
//        naviItem.largeTitleDisplayMode = .always
        
    }
    
    override func setToolbarItem() {
        
        let writeButton = UIBarButtonItem(image: .init(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(touchWriteButton(_:)))
        
        toolbarItems = [.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), writeButton]
    }
    
    func fetchMemoData() {
        
        memos = repository.fetchTasks()
        
    }
    // MARK: - Action Method
    
    @objc func touchWriteButton(_ sender: UIBarButtonItem) {
        
        navigationController?.pushViewController(WriteViewController(), animated: true)
        
    }
    
    // MARK: - UITableView Delegate, DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        
        let memoData = memos[indexPath.row]
        
        cell.mainLabel.text = memoData.title
        
        cell.subLabel.text = dateFormatter.string(from: memoData.creationDate) +  memoData.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = WriteViewController()
        
        vc.currentMemo = memos[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let pinAction = UIContextualAction(style: .normal, title: "") { _, _, completion in
            print("핀 액션")
            completion(true)
        }
        pinAction.image = .init(systemName: "pin.fill")
        pinAction.backgroundColor = .systemOrange
        
        
        return UISwipeActionsConfiguration(actions: [pinAction])
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { _, _, completion in
            print("삭제 액션")
            completion(true)
        }
        deleteAction.image = .init(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    

}
