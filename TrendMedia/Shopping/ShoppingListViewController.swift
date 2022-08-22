//
//  ShoppingListViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

import RealmSwift

class ShoppingListViewController: UITableViewController {

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<ShoppingItem>!
    
    var shoppingList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        headerView.setCornerRadius()
        
        tasks = localRealm.objects(ShoppingItem.self)//.sorted(byKeyPath: "isComplete", ascending: true)
        
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath) as! ShoppingListCell
        
        cell.label.text = tasks[indexPath.row].itemName
        
        cell.starButton.isSelected = tasks[indexPath.row].isFavorite
        cell.starButton.tag = indexPath.row
        
        cell.checkboxButton.isSelected = tasks[indexPath.row].isComplete
        cell.checkboxButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    @IBAction func touchCheckbox(_ sender: UIButton) {
        
//        sender.isSelected.toggle()
        
        let taskToUpdate = tasks[sender.tag]
        try! localRealm.write {
            taskToUpdate.isComplete.toggle()
        }
        
//        print(taskToUpdate.isComplete)
        
        //tasks = localRealm.objects(ShoppingItem.self)
        
        tableView.reloadRows(at: [[0, sender.tag]], with: .automatic)
//        tableView.reloadData()
        
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        guard let text = searchTextfield.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            
            view.makeToast("공백은 안돼욧!",position: .bottom)
            return
        }
        
        
        
        // Add some tasks
        let task = ShoppingItem(name: text)
        try! localRealm.write {
            localRealm.add(task)
        }
        
//        shoppingList.append(text)
        
        tasks = localRealm.objects(ShoppingItem.self)
        
        
//        tableView.reloadData()
        tableView.insertRows(at: [[0, tasks.count-1]], with: .automatic)
        
        searchTextfield.text = nil
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
//            shoppingList.remove(at: indexPath.row)
            
            let taskToDelete = tasks[indexPath.row]
            try! localRealm.write {
                // Delete the LocalOnlyQsTask.
                localRealm.delete(taskToDelete)
            }
            
            tasks = localRealm.objects(ShoppingItem.self)
            
            
//            tableView.reloadData()
            tableView.deleteRows(at: [[0, indexPath.row]], with: .automatic)
            tableView.reloadData()
            /*
            let indexPathes = [Int](indexPath.row...tasks.count).map {
                IndexPath(row: 0, section: $0)
            }
            tableView.reloadRows(at: indexPathes, with: .automatic)
             */
            
        }
    }

 
}
