//
//  URL+Extension.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

extension URL {
    
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    

}
