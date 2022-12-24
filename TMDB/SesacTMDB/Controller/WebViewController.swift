//
//  WebViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/06.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var linkURL = "https://www.youtube.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: linkURL)!))
        
    }
    

}
