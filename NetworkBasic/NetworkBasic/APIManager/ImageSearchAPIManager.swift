//
//  ImageSearchAPIManager.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    typealias completionHandler = (Int, [ImageSearchData]) -> Void
    
    func fetchImageData(query: String, startPage: Int, displayCount: Int, completionHandler: @escaping completionHandler) {
        
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        // 쿼리 스트링으로 파라미터 전달
        let url = EndPoint.iamgeSearchURL + "query=\(text)&display=\(displayCount)&start=\(startPage)&sort=sim"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER, "X-Naver-Client-Secret": APIKey.NAVERKEY]
        
        //        let parameters: Parameters = ["query":"apple" , "display": 30, "sort":"sim" ]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print(json)
                
                let total = json["total"].intValue
                let list = json["items"].arrayValue.map {
                    ImageSearchData(title: $0["title"].stringValue, link: $0["link"].stringValue)
                }
                
                completionHandler(total, list)
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    private init() {}
    
    
}
