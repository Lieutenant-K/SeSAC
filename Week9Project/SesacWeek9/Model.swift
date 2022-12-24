//
//  Model.swift
//  SesacWeek9
//
//  Created by 김윤수 on 2022/08/30.
//
import Foundation

// MARK: - Lotto
struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

struct Person: Codable {
    
    let page, totalPages, totalResults: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}

struct Result: Codable {
    
    let knownForDepartment, name: String
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
        
        
    }
    
    
}
