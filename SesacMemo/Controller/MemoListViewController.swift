//
//  MemoListViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import RealmSwift

final class MemoListViewController: ListViewController {
    
    //MARK: - Properties
    
    private let repository = MemoRealmRepository()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Memo>!
    
    /*
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Memo>!
    
    private var supplementaryRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderLabel>!
    */
    
    var memoCollection = MemoCollection() {
        didSet {
            print(#function)
            reloadMemoData()
//            listView.collectionView.reloadData()
        }
    }
    
    var searchedMemo: Results<Memo>! {
        didSet {
            print(#function)
            reloadMemoData()
//            listView.collectionView.reloadData()
        }
    }
    
    let pinLimit = 5
    
    var isSearching: Bool {
        if let sc = navigationItem.searchController, let text = sc.searchBar.text {
            return sc.isActive && !text.isEmpty
        }
        return false
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
        
        checkIsFirstLaunch()
    }
    
    // MARK: - Method
    
    
    
    // MARK: Helper Method
    
    private func checkIsFirstLaunch() {
        
        if !UserDefaults.standard.bool(forKey: "isAgree") {
            let vc = WalkThroughController()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
        
    }
    
    
    override func setListCollectionView() {
        super.setListCollectionView()
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderLabel>(elementKind: UICollectionView.elementKindSectionHeader) { [unowned self] supplementaryView, elementKind, indexPath in
            
            supplementaryView.label.text = isSearching ? "\(searchedMemo.count)개 찾음" : memoCollection.sectionTitle(section: indexPath.section)
            
        }
        
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Memo> { [unowned self] cell, indexPath, itemIdentifier in
            
            let text = isSearching ? changeSearchKeywordColor(text: itemIdentifier.title) : itemIdentifier.title.attributed(color: .label)
            
            let secondText = isSearching ? "\( itemIdentifier.creationDate.dateString)\t".attributed().combine(to: changeSearchKeywordColor(text: itemIdentifier.subtitle)) : ( itemIdentifier.creationDate.dateString+"\t\(itemIdentifier.subtitle)").attributed(color: .secondaryLabel)
            
            var config = cell.defaultContentConfiguration()
            config.attributedText = text
            config.secondaryAttributedText = secondText
            config.textToSecondaryTextVerticalPadding = 4
            config.textProperties.numberOfLines = 1
//            config.textProperties.lineBreakMode = .byTruncatingTail
            config.secondaryTextProperties.numberOfLines = 1
            config.prefersSideBySideTextAndSecondaryText = false
            
            cell.contentConfiguration = config
            
            
        }
        
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.headerMode = .supplementary
        
        config.leadingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
            
            let task = isSearching ? searchedMemo[indexPath.row] : memoCollection.cellForRowAt(indexPath: indexPath)
            
            let pinAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
                
                self?.pinMemo(memo: task)
                
                completion(true)
            }
            
            pinAction.image = task.isPinned ? UIImage(systemName: "pin.slash.fill") : UIImage(systemName: "pin.fill")
            
            pinAction.backgroundColor = .systemOrange
            
            
            return UISwipeActionsConfiguration(actions: [pinAction])
            
            
        }
        
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
            
            let task = isSearching ? searchedMemo[indexPath.row] : memoCollection.cellForRowAt(indexPath: indexPath)
            
            let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self]  _, _, completion in
                
                self?.showRemovingMemoAlert(memo: task)
                
                completion(true)
                
            }
            deleteAction.image = UIImage(systemName: "trash.fill")
            
            deleteAction.backgroundColor = .systemRed
            
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
            
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        listView.collectionView.collectionViewLayout = layout
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: listView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            
            return cell
            
        })
        
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
            
            return header
        }
        
        
        
    }
    
    func reloadMemoData() {
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Memo>()
    
        let sections = isSearching ? [0] : [Int].init(0..<memoCollection.numberOfSection)
        
        snapshot.appendSections(sections)
        
        if isSearching {
            let list: [Memo] = searchedMemo.map { $0 }
            snapshot.appendItems(list)
        } else {
            if memoCollection.numberOfSection > 1 {
                snapshot.appendItems(memoCollection.memoList, toSection: 1)
                snapshot.appendItems(memoCollection.pinnedMemoList, toSection: 0)
            } else {
                snapshot.appendItems(memoCollection.memoList)
            }
        }
        
        
//        print(memoCollection.memoList)
        
        if #available(iOS 15.0, *) {
            dataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            dataSource.apply(snapshot)
        }
        
        
//        listView.collectionView.reloadSections([0])
        
    }
    
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
    
    
    // MARK:  Memo Method
    
    func fetchMemoData() {
        
        let result = repository.fetchTasks()
        memoCollection.changeValue(result: result)
        
        title = memoCollection.totalMemoCount.decimalString + "개의 메모"
        
    }
    
    func pinMemo(memo: Memo){
        
        if !memo.isPinned && memoCollection.pinnedMemos.count >= pinLimit {
            showAlert(title: "최대 \(pinLimit)개까지만 고정할 수 있습니다.")
            return
        }
        
        do {
            try self.repository.updateTask {
                memo.isPinned.toggle()
            }
            self.fetchMemoData()
        } catch {
            showAlert(title: "작업에 실패했습니다.", message: "다시 시도해주세요")
        }
        
    }
    
    func showRemovingMemoAlert(memo: Memo) {
        
        let okAction = UIAlertAction(title: "예", style: .destructive) { [weak self] _ in
            
            do {
                try self?.repository.deleteTask(task: memo)
                self?.fetchMemoData()
            } catch {
                self?.showAlert(title: "작업에 실패했습니다.", message: "다시 시도해주세요")
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "아니오", style: .default)
        
        showAlert(title: "메모를 삭제하시겠습니까?", actions: [cancelAction, okAction])
        
    }
    
    
    func fetchMemoSearchResult(query: String) {
        
        let result = repository.fetchTasks()
        
        searchedMemo = result.where { $0.content.contains(query) }
        
        
    }
    
    func changeSearchKeywordColor(text: String?) -> NSMutableAttributedString {
        
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
    
    // MARK: Action Method
    
    @objc func touchWriteButton(_ sender: UIBarButtonItem) {
        
        let data = Memo(memoContent: MemoContent())
        
        do {
            try repository.addTask(task: data)
            navigationController?.pushViewController(WriteViewController(memoData: data), animated: true)
            fetchMemoData()
        } catch {
            showAlert(title: "작업에 실패했습니다.", message: "다시 시도해주세요")
        }
        
        
    }
    
    // MARK: - UICollectionView Delegate
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigationItem.backButtonTitle = isSearching ? "검색" : "메모"
        
        let memoData = isSearching ? searchedMemo[indexPath.row] : memoCollection.cellForRowAt(indexPath: indexPath)
        
        let vc = WriteViewController(memoData: memoData)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

// MARK: - UISearchResultUpdating

extension MemoListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        fetchMemoSearchResult(query: searchController.searchBar.text!)
        
    }
    
}
