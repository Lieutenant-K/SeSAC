//
//  ThirdViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/16.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func touchStartButton(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MovieViewController.reuseIdentifier)
        
      
        
        let navi = UINavigationController(rootViewController: vc)
        
        navi.modalPresentationStyle = .fullScreen
        navi.modalTransitionStyle = .crossDissolve
        
        present(navi,animated: true)
        
    }
    

}
