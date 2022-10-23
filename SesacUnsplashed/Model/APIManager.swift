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
    
    func fetchPhotosWithQuery(parameter: [String: Any], completionHandler: @escaping (_ total: Int, _ data: [PhotoResult]) -> Void) {
        
        let url = EndPoint.search(.photos).url
//        let parameter: [String: Any] = ["query": query, "page": page, "per_page": perPage]
        
        requestUnsplashedAPI(url: url, parameter: parameter) { photo in
            
//            completionHandler(photo.total, photo.results)
            
        }
        
    }
    
    func requestUnsplashedAPI(url: String, parameter: Parameters, completionHandler: @escaping (Photo) -> Void) {
        
        let url = url + "?client_id=\(APIKey.accessKey)"
        
        
        AF.request(url, parameters: parameter).responseDecodable(of: Photo.self) { response in
            
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
            
        }
        
        
        /*
        AF.request(url, parameters: parameter).validate(statusCode: 200...600).responseData(queue: .global()) { response in
            
            switch response.result {
                
            case .success(let value):
                
                let json = JSON(value)
                
                print(json)
                
//                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
            
        }
        */
        
    }
    
    private init() {}
    
    
}
