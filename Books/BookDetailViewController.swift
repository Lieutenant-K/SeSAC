//
//  BookDetailViewController.swift
//  Books
//
//  Created by 김윤수 on 2022/07/21.
//

import UIKit

class BookDetailViewController: UIViewController {

    static let identifier = "BookDetailViewController"
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func touchButton(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: BookWebViewController.identifier) as! BookWebViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
