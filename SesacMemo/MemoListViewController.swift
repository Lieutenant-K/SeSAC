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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memos = repository.fetchTasks()
        
//        let memoList = [
//            Memo(title: "메모1", content: "메모1 컨텐츠", creationDate: Date()),
//            Memo(title: "메모2", content: "메모2 컨텐츠", creationDate: Date().addingTimeInterval(86400)),
//            Memo(title: "메모3", content: "메모3 컨텐츠", creationDate: Date().addingTimeInterval(-86400))
//        ]
//
//        memoList.forEach { repository.addTask(task: $0) }
        
    }
    
    override func setNavigationItem() {
        
        title = "메모"
        
        let naviItem = self.navigationItem
        
        naviItem.searchController = UISearchController(searchResultsController: nil)
        naviItem.searchController?.searchBar.placeholder = "검색"
        naviItem.hidesSearchBarWhenScrolling = false
        
    }
    
    override func setToolBarItem() {
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        let writeButton = UIBarButtonItem(image: .init(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(touchWriteButton(_:)))
        
    }
    
    @objc func touchWriteButton(_ sender: UIBarButtonItem) {
        
        
        
    }
    
    // MARK: - UITableView Delegate, DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        
        let memoData = memos[indexPath.row]
        
        cell.mainLabel.text = memoData.title
        cell.subLabel.text = memoData.content
        
        return cell
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
