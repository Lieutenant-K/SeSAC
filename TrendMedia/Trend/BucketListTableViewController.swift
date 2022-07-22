//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {

    var list = ["클레멘타인", "리얼", "이터널스"]
    static let identifier = "BucketListTableViewController"
    var placeholder = ""

    
    @IBOutlet weak var userTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        userTextField.placeholder = "\(placeholder)를 입력해주세요"
        
        navigationItem.title = "버킷리스트"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .init(systemName: "xmark"), style: .plain, target: self, action: #selector(touchCloseButton(_:)))
    }
    
    @objc func touchCloseButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
    }
    

    @IBAction func returnTextField(_ sender: UITextField) {
        
        if let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty, (2...6).contains(text.count) {
            list.append(text)
            tableView.reloadData()
        } else {
            return
        }
        
        /*
        guard let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty, (2...6).contains(text.count) else {
                return
        }
        
        list.append(text)
        tableView.reloadData()
        */
        
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//        tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell
        
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
