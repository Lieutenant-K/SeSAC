//
//  Extension.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/08/30.
//

import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ endPoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        
        let task = dataTask(with: endPoint, completionHandler: completionHandler)
        
        task.resume()
        
        return task
        
    }
    
    static func request<T: Codable>(_ session: URLSession = .shared, endPoint: URLRequest, completionHandler: @escaping (T?, APIError?) -> Void){
        
        session.customDataTask(endPoint) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil, APIError.failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completionHandler(nil, APIError.noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, APIError.invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, APIError.failedRequest)
                    return
                }
                
                
                if let result = try? JSONDecoder().decode(T.self, from: data) {
                    print(result)
                    completionHandler(result, nil)
                }
            }
        }
    
    }
    
}
