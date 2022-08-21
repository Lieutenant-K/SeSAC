//
//  EndPoint.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import Foundation

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
