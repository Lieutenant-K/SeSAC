//
//  ShoppingListViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

import RealmSwift
import Toast

class ShoppingListViewController: UITableViewController {
    
    enum ShoppingListFilter {
        
        case title, favorite, complete
        
        var key: String {
            
            switch self {
                
            case .title:
                return "itemName"
            case .favorite:
                return "isFavorite"
            case .complete:
                return "isComplete"
                
            }
        }
        
    }
    
    // MARK: - Properties
    

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    var repository:ShoppingRepository! = ShoppingRepository()
    
    var tasks: Results<ShoppingItem>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var shoppingList: [String] = []
    
    var currentFilter: ShoppingListFilter = .title
    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTasks()
        
        tableView.rowHeight = 60
        headerView.setCornerRadius()
        
        setMenuButton()

    }
    
    // MARK: - Method
    
    func fetchTasks() {
        
        tasks = repository.fetch(sortKey: currentFilter.key)
        
    }
    
    func setMenuButton() {
        
        let button = navigationItem.rightBarButtonItems![1]
        
        let menuItems = [
            UIAction(title: "제목", state: .on, handler: { [weak self] _ in
                self?.currentFilter = .title
                self?.fetchTasks()
            })
            ,UIAction(title: "즐겨찾기", handler: { [weak self] _ in
                self?.currentFilter = .favorite
                self?.fetchTasks()
                
            })
            ,UIAction(title: "완료", handler: { [weak self] _ in
                self?.currentFilter = .complete
                self?.fetchTasks()
                
            })
        ]
        
        button.menu = UIMenu(title: "정렬 기준", options: .singleSelection, children: menuItems)
        
        
    }
    
    
    // MARK: - UITableView Method
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath) as! ShoppingListCell
        
        cell.label.text = tasks[indexPath.row].itemName
        
        cell.starButton.isSelected = tasks[indexPath.row].isFavorite
        cell.starButton.tag = indexPath.row
        
        cell.checkboxButton.isSelected = tasks[indexPath.row].isComplete
        cell.checkboxButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks != nil ? tasks.count : 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let task = tasks[indexPath.row]
            
            do {
                try repository.delete(taskToDelete: task)
                fetchTasks()
            } catch {
                print(error)
            }
            
            
            
            /*
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadSections([0], with: .automatic)
            tableView.endUpdates()
            */
             
            
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            print(#function)
            
        }
        
        action.image = ImageFileManager.shared.loadImageFromDocument(fileName: tasks[indexPath.row].objectId.stringValue)
        
        action.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transition(ItemDetailViewController(item: tasks[indexPath.row]), transitionStyle: .presentNavigation)
    }
    
    // MARK: - Action Method
    
    @IBAction func touchCheckbox(_ sender: UIButton) {
        
        let taskToUpdate = tasks[sender.tag]
        
        do
        {
            try repository.update {
                
                taskToUpdate.isComplete.toggle()
                
                if taskToUpdate.isComplete {
                    view.makeToast("쇼핑을 완료했습니다", position: .top)
                }
            }
            
            tableView.reloadData()
            
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func touchStarButton(_ sender: UIButton) {
        
        let taskToUpdate = tasks[sender.tag]
        
        do {
            try repository.update {
                
                taskToUpdate.isFavorite.toggle()
                
                if taskToUpdate.isFavorite {
                    view.makeToast("즐겨찾기에 추가됐습니다", position: .top)
                }
            }
            tableView.reloadData()
        } catch {
            print(error)
        }
       
        
        
        
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        guard let text = searchTextfield.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            
            view.makeToast("공백은 입력하실 수 없습니다", duration: 1, position: .top)
            
            return
        }
        
        let task = ShoppingItem(name: text)
        
        do {
            try repository.add(taskToAdd: task)
            fetchTasks()
            searchTextfield.text = nil
        } catch {
            print(error)
        }
        
        
    }
    
    @IBAction func touchSettingButton() {
        print(#function)
        let vc = StorageViewController()
        vc.delegate = self
        transition(vc, transitionStyle: .pageSheet)
    }
    
    deinit {
        print(#function, "ShoppingListViewController")
    }

 
}

extension ShoppingListViewController: RealmUsableDelegate {
    
    func openRealm() {
        
        repository = ShoppingRepository()
        
        print(repository.localRealm.configuration.fileURL)
        
        fetchTasks()
        
        
    }
    
    func prepareToCloseRealm() {
        
        tasks = nil
        repository = nil
        
    }
    
    
}
