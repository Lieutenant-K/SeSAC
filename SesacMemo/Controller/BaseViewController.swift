//
//  BaseViewController.swift
//  SesacMemo
//
//  Created by 김윤수 on 2022/09/01.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setToolbarItem()

        // Do any additional setup after loading the view.
    }
    
    func setNavigationItem() {}

    func setToolbarItem() {}
}
