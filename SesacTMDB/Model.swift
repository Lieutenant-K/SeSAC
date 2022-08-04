//
//  Model.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/03.
//

import UIKit

enum MediaTypes: String {
    
    case all, movie, tv, person
    
}

enum TimeWindows: String {
    
    case day, week
    
}

enum Genres: String {
    
    case movie, tv
    
}

enum ImageSizes {
    
    case backdrop(BackdropSizes)
    case poster(PosterSizes)
    case profile(ProfileSizes)
    
    var size: String {
        switch self {
        case .backdrop(let size):
            return size.rawValue
        case .poster(let size):
            return size.rawValue
        case .profile(let size):
            return size.rawValue
        }
    }
    
}

enum BackdropSizes: String {
    case w300, w780, w1280, original
}

enum PosterSizes: String {
    case w45, w92, w154, w185, w300, w500, original
}

enum ProfileSizes:String {
    
    case w45,w185,h632,original
    
}

enum EndPoint {
    
    case trending(MediaTypes, TimeWindows)
    case image(ImageSizes, String)
    case genre(Genres)
    
    
    var url: String {
        switch self {
        case .trending(let media, let timeWindow):
            return "https://api.themoviedb.org/3/trending/\(media.rawValue)/\(timeWindow.rawValue)"
        case .image(let size, let path):
            return "https://image.tmdb.org/t/p/\(size.size)\(path)"
        case .genre(let genre):
            return "https://api.themoviedb.org/3/genre/\(genre.rawValue)/list"
        }
    }
    
}

struct MovieInfo {
    
    let id: Int
    let title: String
    let postPath: String
    let backdropPath: String
    let releaseDate: String
    let overview: String
    let genre: [String]
}

struct CastInfo {
    
    let name: String
    let department: String
    let character: String
    let profilePath: String
}

struct CrewInfo {
    
    let name: String
    let department: String
    let job: String
    let profilePath: String
}

//struct Genre {
//
//    let id: Int
//    let name: String
//
//}
