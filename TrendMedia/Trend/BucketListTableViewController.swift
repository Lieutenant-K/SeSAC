//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {

    var list = ["클레멘타인", "리얼", "이터널스"]
    @IBOutlet weak var userTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        if IndexPath(row: 1, section: 1) == [1, 1] {
            print("ddd")
        }
        
    }
    

    @IBAction func returnTextField(_ sender: UITextField) {
        
        list.append(sender.text!)
        print(list)
        
        tableView.reloadData()
        
        showAlert()
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//        tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell
        
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .systemFont(ofSize: 20)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return true
        } else {
            return false
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            // 배열 삭제 후 테이블 뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }

    }
    
    

}
