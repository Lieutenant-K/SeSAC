//
//  APIManager.swift
//  SesacUnsplashed
//
//  Created by 김윤수 on 2022/08/21.
//

import UIKit

import SwiftyJSON
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    func fetchPhotosWithQuery(query: String, page: Int, amountOfResultForPage perPage: Int, completionHandler: @escaping (Int, [ImageURL]) -> Void) {
        
        let url = EndPoint.search(.photos).url
        let parameter: [String: Any] = ["query": query, "page": page]
        
        requestUnsplashedAPI(url: url, parameter: parameter) { json in
            
            let total = json["total"].intValue
            let data = json["results"].arrayValue.map {
                
                ImageURL(thumb: $0["urls"]["thumb"].stringValue, full: $0["urls"]["full"].stringValue)
                
            }
            
            completionHandler(total, data)
            
        }
        
    }
    
    func requestUnsplashedAPI(url: String, parameter: Parameters, completionHandler: @escaping (JSON) -> Void) {
        
        let url = url + "?client_id=\(APIKey.accessKey)"
        
        AF.request(url, parameters: parameter).validate(statusCode: 200...600).responseData(queue: .global()) { response in
            
            switch response.result {
                
            case .success(let value):
                
                let json = JSON(value)
                
                print(json)
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    private init() {}
    
    
}
