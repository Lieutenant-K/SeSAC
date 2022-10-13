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

    }
    
    func setNavigationItem() {}

    func setToolbarItem() {}
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
