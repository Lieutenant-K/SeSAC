//
//  RealmModel.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/22.
//

import Foundation

import RealmSwift

class SearchRecord: Object {
    
    @Persisted(primaryKey: true) var dateString: String
    
    @Persisted var movieData: List<MovieData>
    
    convenience init(date: String, data: List<MovieData>){
        self.init()
        dateString = date
        movieData = data
    }
    
}

class MovieData: Object {
    
    @Persisted var movieTitle: String
    @Persisted var releaseDate: String
    @Persisted var totalAudience: String
    
    convenience init(title: String, date: String, total: String){
        self.init()
        self.movieTitle = title
        self.releaseDate = date
        self.totalAudience = total
    }
    
}
