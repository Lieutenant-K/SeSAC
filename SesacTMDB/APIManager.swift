//
//  APIManager.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    
    // available only movie media type
    func fetchTrendingItems(timeWindow: TimeWindows, page: Int, completionHandler: @escaping (Int, [MovieInfo]) -> Void) {
        
        let url = EndPoint.trending(.movie, timeWindow).url
        
        requestTMDBData(url: url, parameter: ["page": page]) { jsonData in
            
            let total = jsonData["total_results"].intValue
            
            let list = jsonData["results"].arrayValue.map { item in
                MovieInfo(id:item["id"].intValue,
                          title: item["title"].stringValue,
                          postPath: item["poster_path"].stringValue,
                          backdropPath: item["backdrop_path"].stringValue,
                          releaseDate: item["release_date"].stringValue,
                          overview: item["overview"].stringValue,
                          genre: item["genre_ids"].arrayValue.map{ $0.intValue })
            }
            
            completionHandler(total, list)
        }
    }
    
    func fetchGenreDictionary(media: GenreMediaTypes, completionHandler: @escaping ([Int: String]) -> Void) {
        
        let url = EndPoint.genre(media).url
        
        requestTMDBData(url: url) { data in
            
            let dict = Dictionary(uniqueKeysWithValues: data["genres"].arrayValue.map { ($0["id"].intValue, $0["name"].stringValue) })
            
            completionHandler(dict)
        }
        
    }
    
    func fetchCreditDetails(genre: GenreMediaTypes, id: Int, completionHandler: @escaping ([[DisplayInCell]])-> Void) {
        
        let url = EndPoint.credit(genre, id).url
        
        requestTMDBData(url: url) { jsonData in
            
            let castList = jsonData["cast"].arrayValue.map { item in
                
                CastInfo(name:item["name"].stringValue,
                         department: item["known_for_department"].stringValue,
                         character: item["character"].stringValue,
                         imagePath: item["profile_path"].stringValue)
            }
            
            let crewList = jsonData["crew"].arrayValue.map { item in
                
                CrewInfo(name:item["name"].stringValue,
                                    department: item["department"].stringValue,
                                    job: item["job"].stringValue,
                                    imagePath: item["profile_path"].stringValue)
                
            }
            completionHandler([castList, crewList])
        }
        
        
    }
    
    func fetchVideos(genre: GenreMediaTypes, id: Int, completionHandler: @escaping (String?) -> Void) {
        
        let url = EndPoint.video(genre, id).url
        
        requestTMDBData(url: url) { jsonData in
            
            let result = jsonData["results"].arrayValue
                
            let videoURL = result.isEmpty ? nil : "https://www.youtube.com/watch?v=\(result[0]["key"].stringValue)"
            
            completionHandler(videoURL)
        }
        
        
    }
    
    func requestTMDBData(url: String, parameter: Parameters? = nil, completionHandler: @escaping (_ jsonData : JSON) -> Void) {
        
        // 쿼리 스트링으로 파라미터 전달
        let url = url + "?api_key=\(APIKey.movieKey)"
        
        AF.request(url, method: .get, parameters: parameter).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                completionHandler(json)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private init() {}
    
}
