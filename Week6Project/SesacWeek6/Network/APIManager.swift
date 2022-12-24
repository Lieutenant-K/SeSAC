//
//  APIManager.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
    
    private init() {}
    
    // Alamofire + SwiftyJSON
    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (JSON) -> ()) {
        
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = type.requestURL + text
        
        // Alamofire -> URLSession -> 비동기로 Request
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in
                   switch response.result {
                   case .success(let value):
                       
                       let json = JSON(value)
//                       print(json)
                       completionHandler(json)
                       
                   case .failure(let error):
                       print(error)
                   }
               }
    }
    
    
}
