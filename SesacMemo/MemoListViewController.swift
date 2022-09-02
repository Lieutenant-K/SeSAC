//
//  MemoListViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import RealmSwift

final class MemoListViewController: ListViewController {

    private let repository = MemoRealmRepository()
    
    var memos: Results<Memo>! {
        didSet {
            
            title = "\(memos.count)개의 메모"
            listView.tableView.reloadData()
            
        }
    }
    
    private let dateFormatter: DateFormatter = {
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
        repository.getURL()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print(#function)
        
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
    
    func pinMemo(memo: Memo){
        
        do {
            try self.repository.updateTask {
                memo.isPinned.toggle()
            }
            self.fetchMemoData()
        } catch {
            print(error)
        }
        
    }
    
    func showRemovingMemoAlert(memo: Memo) {
        
        let alert = UIAlertController(title: "메모를 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "예", style: .destructive) { [weak self] _ in
            
            do {
                try self?.repository.deleteTask(task: memo)
                self?.fetchMemoData()
            } catch {
                print(error)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "아니오", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    // MARK: - Action Method
    
    @objc func touchWriteButton(_ sender: UIBarButtonItem) {
        
        let data = Memo(memoContent: MemoContent())
        
        do {
            try repository.addTask(task: data)
            navigationController?.pushViewController(WriteViewController(memoData: data), animated: true)
            fetchMemoData()
        } catch {
            print(error)
        }
    
        
    }
    
    // MARK: - UITableView Delegate, DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        
        let memoData = memos[indexPath.row]
        
        cell.mainLabel.text = memoData.title
        
        cell.subLabel.text = dateFormatter.string(from: memoData.creationDate) +  "\t\(memoData.subtitle)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = WriteViewController(memoData: memos[indexPath.row])
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = memos[indexPath.row]
        
        let pinAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completion in
            
            self?.pinMemo(memo: task)
            
            completion(true)
        }
        
        pinAction.image = task.isPinned ? .init(systemName: "pin.slash.fill") : .init(systemName: "pin.fill")
        
        pinAction.backgroundColor = .systemOrange
        
        
        return UISwipeActionsConfiguration(actions: [pinAction])
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = memos[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self]  _, _, completion in
            
            self?.showRemovingMemoAlert(memo: task)
        
            completion(true)
            
        }
        deleteAction.image = .init(systemName: "trash.fill")
        
        deleteAction.backgroundColor = .systemRed
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    

}
