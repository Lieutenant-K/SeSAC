//
//  EndPoint.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import Foundation
import UIKit
import Kingfisher

enum resourceType: String {
    
    case photos, collections, users
    
}

enum EndPoint {
    
    static let baseURL = "https://api.unsplash.com/"
    
    case search(resourceType)
    
    var url: String {
        
        switch self{
        case .search(let resource):
            return Self.baseURL + "search/\(resource)"
        }
        
    }
    
}

struct ImageURL {
    
    let thumb: String
    let full: String
    
}

struct Parameter {
    
    let page: Int
    let query: String
    let itemsPerPage: Int
    
    var paramter: [String: Any] {
        return ["page": page, "query": query, "per_page": itemsPerPage]
    }
    
}

extension NSNotification.Name {
        
    static let sendImageURLNotification = Self.init(rawValue: "sendImageURLNotification")
    
}

extension UIImageView {
    
    func setImage(url: String) {
        
        let url = URL(string: url)
        
        self.kf.setImage(with: url)
        
    }
    
}
