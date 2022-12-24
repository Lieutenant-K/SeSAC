//
//  SearchDiaryController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/28.
//

import UIKit
import SnapKit
import RealmSwift

class SearchDiaryController: UIViewController {

    let repository = UserDiaryRepository()
    
    lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchResultsUpdater = self
//        view.obscuresBackgroundDuringPresentation = true
       return view
        
    }()
    
    var tasks: Results<UserDiary>! {
        didSet {
            tableView.reloadSections([0], with: .automatic)
        }
    }
    
    lazy var tableView: UITableView = {
       let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tasks = repository.fetch(sortKey: "diaryTitle")
    }
    
}

extension SearchDiaryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var config = UIListContentConfiguration.cell()
        config.text = tasks[indexPath.row].diaryTitle
        config.secondaryText = tasks[indexPath.row].diaryContent
        config.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        config.imageProperties.maximumSize = .init(width: 0, height: 44)
        
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}

extension SearchDiaryController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            tasks = repository.fetch(sortKey: "diaryTitle")
            return
        }
        
        tasks = repository.fetch(sortKey: "diaryTitle").where{$0.diaryTitle.contains(text)}
        
//        tableView.reloadData()
        
//        tableView.reloadSections([0], with: .automatic)
        
    }
    
    
}
