//
//  RestartViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/08/27.
//

import UIKit

class RestartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func touchRestartButton(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "Shopping")
        
        restartToViewController(vc: vc)
        
    }
    
    deinit{
        print(#function, String(describing: self))
    }
    

}
