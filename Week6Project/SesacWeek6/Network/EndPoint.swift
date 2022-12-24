//
//  EndPoint.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/08.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    
    var requestURL:  String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
}
