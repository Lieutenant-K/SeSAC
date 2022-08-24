//
//  ViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit
import SnapKit
import RealmSwift
import SwiftUI

class ViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        
//        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true)
        
//        print(tasks)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(touchPlusButton))
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(touchSortButton))
            ,UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(touchFilterButton))
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    // MARK: - Method
    
    
    func fetchRealm() {
        
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
        
    }
    
    
    
    // MARK: - Action Method
    
    @objc func touchPlusButton() {
        
//        navigationController?.pushViewController(PostViewController(), animated: true)
        
        transition(PostViewController(), transitionStyle: .presentFullNaviagtion)
        
    }
    
    @objc func touchSortButton() {
        
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "postingDate", ascending: true)

    }
    
    // realm filter query, NSPredicate
    @objc func touchFilterButton() {
        
        tasks = localRealm.objects(UserDiary.self).where({
            $0.diaryTitle.contains("오늘")
        })
        
    }

}


// MARK: - TableView Method

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        cell.imageView?.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favortie = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            try! self.localRealm.write {
                
//                self.tasks[indexPath.row].favorite.toggle()
                
                // favorite 프로퍼티(컬럼) 에 해당하는 모든 값 변경
                self.tasks.setValue(true, forKey: "favorite")
                
                // 특정 objectId(PK)에 해당하는 레코드의 diaryTitle 컬럼 값 변경
                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "diaryTitle":"수정된 제목"], update: .modified)
            }
            
//            self.tableView.reloadRows(at: [indexPath], with: .none)
            self.fetchRealm()
            
        }
        
        favortie.image = tasks[indexPath.row].favorite ? .init(systemName: "star.fill") : .init(systemName: "star")
        favortie.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [favortie])
    }
}
