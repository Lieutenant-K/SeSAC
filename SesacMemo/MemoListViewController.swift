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
    
    var memoCollection = MemoCollection()
    var searchedMemo: Results<Memo>!
    
    var isSearching: Bool {
        guard let sc = navigationItem.searchController else { return false }
        return sc.isActive && !sc.searchBar.text!.isEmpty
    }
    
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
        naviItem.searchController?.searchBar.setValue("취소", forKey: "cancelButtonText")
        naviItem.searchController?.searchResultsUpdater = self
        naviItem.hidesSearchBarWhenScrolling = false
        naviItem.backButtonTitle = "메모"
//        naviItem.largeTitleDisplayMode = .always
        
    }
    
    override func setToolbarItem() {
        
        let writeButton = UIBarButtonItem(image: .init(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(touchWriteButton(_:)))
        
        toolbarItems = [.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), writeButton]
    }
    
    func fetchMemoData() {
        
        let result = repository.fetchTasks()
        memoCollection.changeValue(result: result)
        
        listView.tableView.reloadData()
        
        title = "\(memoCollection.totalMemoCount)개의 메모"
        
    }
    
    func checkPinMemoCount() -> Bool {
        
        if memoCollection.pinnedMemos.count >= 5 {
            
            let alert = UIAlertController(title: "5개까지만 고정할 수 있습니다.", message: nil, preferredStyle: .alert)
            
            alert.addAction(.init(title: "확인", style: .cancel))
            
            present(alert, animated: true)
            
            return false
        }
        
        return true
    }
    
    func pinMemo(memo: Memo){
        
        if !memo.isPinned && !checkPinMemoCount() { return }
        
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
    
    func getDateStringForCell(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        let calendar = Calendar(identifier: .iso8601)
        
        let now = Date()
        let firstDayOfWeek = calendar.dateComponents([.calendar, .weekOfYear, .yearForWeekOfYear], from: now).date!
        let startOfToday = calendar.startOfDay(for: now)
        
        if date >= startOfToday {
            
            formatter.dateFormat = "a hh:mm"
            
            return formatter.string(from: date)
            
        } else if date >= firstDayOfWeek {
            
            let weekday = calendar.dateComponents([.weekday], from: date).weekday!
            
            return formatter.weekdaySymbols[weekday-1]
            
        } else {
            
            formatter.dateFormat = "yyyy. MM. dd a hh:mm"
            
            return formatter.string(from: date)
        }
        
        
    }
    
    func searchingMemo(query: String) {
        
        let result = repository.fetchTasks()
        
        searchedMemo = result.where { $0.content.contains(query) }
        
        listView.tableView.reloadData()
        
//        title = "\(searchedMemo.count)개 찾음"
        
        
    }
    
    func changeSearcedKeywordColor(text: String?) -> NSMutableAttributedString {
        
        guard let query = navigationItem.searchController?.searchBar.text, let text = text else { return NSMutableAttributedString(string: "") }

        let attrString = NSMutableAttributedString(string: text)
        
        var searchRange = text.startIndex ..< text.endIndex
        
        // 대소문자 구분하지 않고 텍스트에서 키워드 범위 찾기
        while let range = text.range(of: query, options: .caseInsensitive, range: searchRange) {
            attrString.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: NSRange(range, in: text))
            searchRange = range.upperBound ..< searchRange.upperBound
        }
        
        return attrString
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : memoCollection.numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isSearching ? searchedMemo.count : memoCollection.numberOfRowsInSection(section: section)
   
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listCellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        
        if isSearching {
            let memoData = searchedMemo[indexPath.row]
            
            cell.mainLabel.attributedText = changeSearcedKeywordColor(text: memoData.title)
            
            let subtitle = NSMutableAttributedString(string: "\(getDateStringForCell(date: memoData.creationDate))\t")
            
            subtitle.append(changeSearcedKeywordColor(text: memoData.subtitle))
            
            cell.subLabel.attributedText = subtitle
            
        } else {
            
            let memoData = memoCollection.cellForRowAt(indexPath: indexPath)
            
            cell.mainLabel.attributedText = NSAttributedString(string: memoData.title, attributes: [.foregroundColor: UIColor.label])
            
            let subtitle = getDateStringForCell(date: memoData.creationDate) +  "\t\(memoData.subtitle)"
            
            cell.subLabel.attributedText = NSAttributedString(string: subtitle, attributes: [.foregroundColor: UIColor.secondaryLabel])
            
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationItem.backButtonTitle = isSearching ? "검색" : "메모"
        
        let memoData = isSearching ? searchedMemo[indexPath.row] : memoCollection.cellForRowAt(indexPath: indexPath)
        
        let vc = WriteViewController(memoData: memoData)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = isSearching ? searchedMemo[indexPath.row] : memoCollection.cellForRowAt(indexPath: indexPath)

        let pinAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            
            self?.pinMemo(memo: task)
            
            completion(true)
        }
        
        pinAction.image = task.isPinned ? .init(systemName: "pin.slash.fill") : .init(systemName: "pin.fill")
        
        pinAction.backgroundColor = .systemOrange
        
        
        return UISwipeActionsConfiguration(actions: [pinAction])
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = isSearching ? searchedMemo[indexPath.row] : memoCollection.cellForRowAt(indexPath: indexPath)
        
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self]  _, _, completion in
            
            self?.showRemovingMemoAlert(memo: task)
        
            completion(true)
            
        }
        deleteAction.image = .init(systemName: "trash.fill")
        
        deleteAction.backgroundColor = .systemRed
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.numberOfLines = 1
        view.text = isSearching ? "\(searchedMemo.count)개 찾음" : memoCollection.sectionTitle(section: section)
        view.textColor = .label
        view.font = .systemFont(ofSize: 28, weight: .semibold)
        
        return view
    }
    

}

extension MemoListViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchingMemo(query: searchController.searchBar.text!)
        
    }
    
}

extension MemoListViewController {
    
    struct MemoCollection {
        
        var pinnedMemos: Results<Memo>!
        var memos: Results<Memo>!
        
        var numberOfSection: Int {
            return (pinnedMemos.count > 0 ? 1 : 0) + 1
        }
        
        var totalMemoCount: Int {
            pinnedMemos.count + memos.count
        }
        
        mutating func changeValue(result: Results<Memo>) {
            pinnedMemos = result.where { $0.isPinned == true }
            memos = result.where { $0.isPinned == false }
        }
        
        func numberOfRowsInSection(section: Int) -> Int {
            numberOfSection > 1 ? [pinnedMemos, memos][section].count : memos.count
        }
        
        func cellForRowAt(indexPath: IndexPath) -> Memo {
            numberOfSection > 1 ? [pinnedMemos, memos][indexPath.section][indexPath.row] : memos[indexPath.row]
        }
        
        func sectionTitle(section: Int) -> String {
            numberOfSection > 1 ? ["고정된 메모", "메모"][section] : "메모"
        }
    }
}
