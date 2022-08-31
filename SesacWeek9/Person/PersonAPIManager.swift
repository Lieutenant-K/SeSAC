//
//  PersonAPIManager.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    
    static func requestPerson(query: String, completionHandler: @escaping (Person?, APIError?) -> Void){
        
//        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=c60c7d9d33bb2861af8965fe039773dd&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "c60c7d9d33bb2861af8965fe039773dd"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
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
                
                
                if let result = try? JSONDecoder().decode(Person.self, from: data) {
                    print(result)
                    completionHandler(result, nil)
                }
                
            }
            
          
            
            
        }.resume()

    }
    
        
}
