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

// MARK: - Photo
struct Photo: Codable {
    let results: [PhotoResult]
    let totalPages, total: Int

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case total
    }
}

struct PhotoResult: Codable, Hashable, Equatable {
    
    static func == (lhs: PhotoResult, rhs: PhotoResult) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let urls: Urls
    let likes: Int
    let id: String
    let photoDescription: String?
    

    enum CodingKeys: String, CodingKey {
        case urls
        case likes, id
        case photoDescription = "description"
    }
}

struct Urls: Codable {
    let thumb, small, raw, regular: String
    let full, smallS3: String

    enum CodingKeys: String, CodingKey {
        case thumb, small, raw, regular, full
        case smallS3 = "small_s3"
    }
}
