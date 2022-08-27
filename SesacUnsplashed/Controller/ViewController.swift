//
//  ViewController.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit
import SnapKit
import RealmSwift
import FSCalendar

class ViewController: UIViewController {
    
    let repository = UserDiaryRepository()
    
    lazy var calendar: FSCalendar = {
        
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
        
    }()
    
    let formatter: DateFormatter = {
        
        let view = DateFormatter()
        view.dateFormat = "yyMMdd"
        return view
    }()
    
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
        view.addSubview(calendar)
        
//        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true)
        
//        print(tasks)
        
        calendar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(calendar.snp.bottom)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(touchPlusButton))
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(touchSortButton))
            ,UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(touchFilterButton))
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm(sortKey: "diaryTitle")
    }
    
    // MARK: - Method
    
    
    func fetchRealm(sortKey: String) {
        
        tasks = repository.fetch(sortKey: sortKey)
        
    }
    
    
    
    // MARK: - Action Method
    
    @objc func touchPlusButton() {
        
//        navigationController?.pushViewController(PostViewController(), animated: true)
        
        transition(PostViewController(), transitionStyle: .presentFullNaviagtion)
        
    }
    
    @objc func touchSortButton() {
        
        fetchRealm(sortKey: "postingDate")

    }
    
    // realm filter query, NSPredicate
    @objc func touchFilterButton() {
        
        tasks = repository.filter(containWord: "오늘")
        
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
        
        let task = tasks[indexPath.row]
        
        let favortie = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            
            self.repository.updateFavorite(taskToUpdate: task)
            
            self.fetchRealm(sortKey: "diaryTitle")
            
        }
        
        favortie.image = task.favorite ? .init(systemName: "star.fill") : .init(systemName: "star")
        favortie.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [favortie])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            
            let task = self.tasks[indexPath.row]
            
            do {
                
                try self.repository.delete(taskToDelete: task)
                
                self.removeImageFromDocument(fileName: "\(task.objectId).jpg")
                
                self.fetchRealm(sortKey: "diaryTitle")
                
            } catch {
                self.showAlert(title: "다이어리 삭제 실패")
            }
            
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        "앙 새싹띠"
//    }
//
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        tasks = repository.fetchDate(date: date)

    }

    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        .init(systemName: "star")
//    }
//
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }
     
    
}

