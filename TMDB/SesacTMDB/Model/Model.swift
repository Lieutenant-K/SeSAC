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

enum GenreMediaTypes: String {
    
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
    case genre(GenreMediaTypes)
    case credit(GenreMediaTypes, Int)
    case video(GenreMediaTypes, Int)
    case recommendation(GenreMediaTypes, Int)
    
    static let base = "https://api.themoviedb.org/3/"
    
    var url: String {
        switch self {
        case .trending(let media, let timeWindow):
            return EndPoint.base + "trending/\(media.rawValue)/\(timeWindow.rawValue)"
        case .image(let size, let path):
            return "https://image.tmdb.org/t/p/\(size.size)\(path)"
        case .genre(let genre):
            return EndPoint.base + "genre/\(genre.rawValue)/list"
        case .credit(let genre, let id):
            return EndPoint.base + "\(genre.rawValue)/\(id)/credits"
        case .video(let genre, let id):
            return EndPoint.base + "\(genre)/\(id)/videos"
        case .recommendation(let genre, let id):
            return EndPoint.base + "\(genre)/\(id)/recommendations"
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
    let genre: [Int]
}

struct CastInfo: DisplayInCell {
    
    let name: String
    let department: String
    let character: String
    let imagePath: String
    
    var titleText: String {
        name
    }
    
    var subText: String {
        "\(character) / \(department)"
    }
}

struct CrewInfo: DisplayInCell {
    
    let name: String
    let department: String
    let job: String
    let imagePath: String
    
    var titleText: String {
        name
    }
    
    var subText: String {
        "\(job) / \(department)"
    }
}
