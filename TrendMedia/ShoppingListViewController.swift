//
//  ShoppingListViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

class ShoppingListViewController: UITableViewController {

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    var shoppingList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        headerView.setCornerRadius()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath) as! ShoppingListCell
        
        cell.label.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    @IBAction func touchCheckbox(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        shoppingList.append(searchTextfield.text!)
        tableView.reloadData()
        
        searchTextfield.text = nil
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }

 
}
