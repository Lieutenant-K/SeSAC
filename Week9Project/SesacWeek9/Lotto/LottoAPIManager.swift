//
//  LottoAPIManager.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/08/30.
//

import Foundation

// shared - 커스텀하지 않고 사용, 응답 클로저 사용, 백그라운드 X
// default configuration - shared 설정과 유사함. 커스텀 O(셀룰러 연결 여부, 타임 아웃 간격), 응답 클로저 + 딜리게이트

enum APIError: Error {
    
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
    
    
}

class LottoAPIManager {
    
    static func requestLotto(drwNo: Int, completionHandler: @escaping (Lotto?, APIError?) -> Void ) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
                
                
                if let result = try? JSONDecoder().decode(Lotto.self, from: data) {
                    print(result)
                    completionHandler(result, nil)
                }
            }
            
          
            
            
        }.resume()
        
        
    }
    
}
