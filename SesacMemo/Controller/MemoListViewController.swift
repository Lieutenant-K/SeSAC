//
//  MemoListViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit
import RealmSwift
import RxSwift

final class MemoListViewController: ListViewController {
    
    //MARK: - Properties
    
    private let repository = MemoRealmRepository()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Memo>!
    
    private let viewModel = MemoListViewModel()
    
    private let disposeBag = DisposeBag()
    
    var writeButton: UIBarButtonItem?
    
    var isSearching: Bool {
        if let sc = navigationItem.searchController, let text = sc.searchBar.text {
            return sc.isActive && !text.isEmpty
        }
        return false
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        viewModel.fetchMemoCollection()
        repository.getURL()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchMemoCollection()
        
        checkIsFirstLaunch()
    }
    
    // MARK: - Method
    
    func binding() {
        
        viewModel.memoCollection
            .withUnretained(self)
            .subscribe(onNext: { vc, value in
                vc.reloadMemoData(collection: value)
                vc.title = vc.viewModel.totalCount + "개의 메모"
            })
            .disposed(by: disposeBag)
        
        viewModel.memoError
            .map { $0.alertMessage }
            .withUnretained(self)
            .bind{ vc, message in
                vc.showAlert(title: message) }
            .disposed(by: disposeBag)
        
        navigationItem.searchController?.searchBar
            .rx.text.orEmpty
            .withUnretained(self)
            .bind { vc, query in
                vc.viewModel.fetchMemoSearchResult(query: query)
            }
            .disposed(by: disposeBag)
        
        listView.collectionView.rx
            .itemSelected
            .withUnretained(self)
            .bind { vc, indexPath in
                vc.navigationItem.backButtonTitle = vc.viewModel.isSearching ? "검색" : "메모"
                
                let snapshot = vc.dataSource.snapshot(for: indexPath.section)
                
                let memoData = snapshot.items[indexPath.row]
                
                let writeVC = WriteViewController(memoData: memoData)
                
                vc.navigationController?.pushViewController(writeVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        navigationItem.searchController?.searchBar.rx.cancelButtonClicked
            .withUnretained(self)
            .bind(onNext: { (vc, _) in
                vc.viewModel.fetchMemoSearchResult(query: "")
            })
            .disposed(by: disposeBag)
        
        writeButton?.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.createMemo { memo in
                    vc.navigationController?.pushViewController(WriteViewController(memoData: memo), animated: true)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    // MARK: Helper Method
    
    private func checkIsFirstLaunch() {
        
        if !UserDefaults.standard.bool(forKey: "isAgree") {
            let vc = WalkThroughController()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
        
    }
    
    func reloadMemoData(collection: [[Memo]]) {
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Memo>()
        
        let sectionCount = collection.count
        
        let sections = [Int].init(0..<sectionCount)
        
        sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(collection[$0],toSection: $0)
        }
        
        
        if #available(iOS 15.0, *) {
            dataSource.applySnapshotUsingReloadData(snapshot)
//            dataSource.apply(snapshot)
        } else {
            dataSource.apply(snapshot)
        }
        
        
        
    }
    
    override func setNavigationItem() {
        
        title = "메모"
        
        let naviItem = self.navigationItem
        
        naviItem.searchController = UISearchController(searchResultsController: nil)
        naviItem.searchController?.searchBar.placeholder = "검색"
        naviItem.searchController?.searchBar.setValue("취소", forKey: "cancelButtonText")
//        naviItem.searchController?.searchResultsUpdater = self
        naviItem.hidesSearchBarWhenScrolling = false
        naviItem.backButtonTitle = "메모"
        
    }
    
    override func setToolbarItem() {
        
        writeButton = UIBarButtonItem(image: .init(systemName: "square.and.pencil"), style: .plain, target: nil, action: nil)
        
        toolbarItems = [.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), writeButton!]
    }
    
    
    // MARK:  Memo Method
    
    func showRemovingMemoAlert(memo: Memo) {
        
        let okAction = UIAlertAction(title: "예", style: .destructive) { [weak self] _ in
            
            self?.viewModel.deleteMemo(memo: memo)
            
        }
        
        let cancelAction = UIAlertAction(title: "아니오", style: .default)
        
        showAlert(title: "메모를 삭제하시겠습니까?", actions: [cancelAction, okAction])
        
    }
    
    
    func fetchMemoSearchResult(query: String) {
        
        let result = repository.fetchTasks()
        
        viewModel.searchResult = result.where { $0.content.contains(query) }
        
        
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
    
    
    // MARK: - UICollectionView Delegate
    
    override func setListCollectionView() {
        super.setListCollectionView()
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderLabel>(elementKind: UICollectionView.elementKindSectionHeader) { [unowned self] supplementaryView, elementKind, indexPath in
            
            let snapshot = dataSource.snapshot(for: indexPath.section)
            let itemCount = snapshot.items.count
            
            supplementaryView.label.text = viewModel.isSearching ? "\(itemCount)개 찾음" : viewModel.memoData.sectionTitle(section: indexPath.section)
            
        }
        
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Memo> { [unowned self] cell, indexPath, itemIdentifier in
            
            let text = viewModel.isSearching ? changeSearchKeywordColor(text: itemIdentifier.title) : itemIdentifier.title.attributed(color: .label)
            
            let secondText = viewModel.isSearching ? "\( itemIdentifier.creationDate.dateString)\t".attributed().combine(to: changeSearchKeywordColor(text: itemIdentifier.subtitle)) : ( itemIdentifier.creationDate.dateString+"\t\(itemIdentifier.subtitle)").attributed(color: .secondaryLabel)
            
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
            
            let snapshot = dataSource.snapshot(for: indexPath.section)
            
            let task = snapshot.items[indexPath.row]
        
            let pinAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
                
                self?.viewModel.pinMemo(memo: task)
                
            }
            
            pinAction.image = task.isPinned ? UIImage(systemName: "pin.slash.fill") : UIImage(systemName: "pin.fill")
            
            pinAction.backgroundColor = .systemOrange
            
            
            return UISwipeActionsConfiguration(actions: [pinAction])
            
            
        }
        
        config.trailingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
            
            let snapshot = dataSource.snapshot(for: indexPath.section)
            
            let task = snapshot.items[indexPath.row]
            
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
    
}
