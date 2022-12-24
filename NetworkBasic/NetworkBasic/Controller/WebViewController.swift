//
//  WebViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        openWebPage(url: destinationURL)
        
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
    }

    @IBAction func touchBackButton(_ sender: UIBarButtonItem) {
        
        webView.goBack()
        
    }
    
    @IBAction func touchForwardButton(_ sender: UIBarButtonItem) {
        
        webView.goForward()
        
    }
    @IBAction func touchRefreshButton(_ sender: UIBarButtonItem) {
        
        webView.reload()
        
    }
}

extension WebViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        openWebPage(url: text)
        
    }
    
    
    
}
