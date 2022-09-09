//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}


class BucketListTableViewController: UITableViewController {

    var list = [Todo(title: "클레멘타인", done: false), Todo(title: "리얼", done: false)] {
        didSet {
//            tableView.reloadData()
        }
    }
    
    static let identifier = "BucketListTableViewController"
    var placeholder = ""

    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            
            userTextField.textAlignment = .center
            userTextField.font = .systemFont(ofSize: 22)
            userTextField.textColor = .systemPink
            print("텍스트 필드 변경")
            
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        userTextField.placeholder = "\(placeholder)를 입력해주세요"
        
        navigationItem.title = "버킷리스트"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .init(systemName: "xmark"), style: .plain, target: self, action: #selector(touchCloseButton(_:)))
    }
    
    
    // MARK: Action Method
    
    /// 시작화면으로 돌아가는 메서드
    @objc func touchCloseButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
    }
    

    @IBAction func returnTextField(_ sender: UITextField) {
        
        if let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty, (2...6).contains(text.count) {
            list.append(Todo(title: text, done: false))
//            tableView.reloadData()
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
    
    
    // MARK: TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell
        
        cell.bucketListLabel.text = list[indexPath.row].title
        cell.bucketListLabel.font = .systemFont(ofSize: 20)
        cell.checkboxButton.tag = indexPath.row
        
        let image: UIImage? = list[indexPath.row].done ? .init(systemName: "checkmark.square.fill") : .init(systemName: "checkmark.square")
        
        cell.checkboxButton.setImage(image, for: .normal)
        
        
        cell.checkboxButton.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        
        return cell
        
    }
    
    /// 테이블 뷰의 편집 가능 옵션 설정
    /// - Parameters:
    ///   - tableView: 테이블뷰
    ///   - indexPath: 인덱스
    /// - Returns: 참 또는 거짓
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            // 배열 삭제 후 테이블 뷰 갱신
            list.remove(at: indexPath.row)
//            tableView.reloadData()
        }

    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        
        list[sender.tag].done.toggle()
        tableView.reloadRows(at: [[0, sender.tag]], with: .fade)
//        sender.setImage(.init(systemName: "checkmark.square.fill"), for: .normal)
        
    }
    

}
