//
//  ViewController.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lottoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var list: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottoAPIManager.requestLotto(drwNo: 1027) { lotto, error in
            
            guard let lotto = lotto else {
                return
            }
            
            self.lottoLabel.text = String(lotto.bnusNo)
            
            
        }
        
        PersonAPIManager.requestPerson(query: "park") { person, error in
            
            self.list = person
            self.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view.
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list?.results[indexPath.row].name
        cell.detailTextLabel?.text = list?.results[indexPath.row].knownForDepartment
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.results.count ?? 0
    }
    
    
    
}
