//
//  MovieCell.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/03.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            imageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowOpacity = 0.5
            containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            containerView.layer.shadowRadius = 7
            
        }
    }
    
    func configurateCell(movieInfo: MovieInfo, genreDict: [Int: String]) {
        
        releaseDateLabel.text = movieInfo.releaseDate
        
        titleLabel.text = movieInfo.title
        
        imageView.kf.setImage(with: URL(string: EndPoint.image(.backdrop(.w780), movieInfo.backdropPath).url))
        
        overviewLabel.text = movieInfo.overview
        
        genresLabel.text =  movieInfo.genre.map { "#" + (genreDict[$0] ?? "No Genre") }.joined(separator: " ")
    }
    
}
