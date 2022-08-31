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
    
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottoAPIManager.requestLotto(drwNo: 1027) { lotto, error in
            
            guard let lotto = lotto else {
                return
            }
            
            self.lottoLabel.text = String(lotto.bnusNo)
            
            
        }
        
        viewModel.fetchPerson(query: "park")
        
        viewModel.list.bind { person in
            print("viewController bind")
//            self.viewModel.list.value = person
            self.tableView.reloadData()
        }
   
        // Do any additional setup after loading the view.
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.knownForDepartment
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    
    
}
