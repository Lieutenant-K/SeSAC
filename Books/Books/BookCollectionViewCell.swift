//
//  BookCollectionViewCell.swift
//  Books
//
//  Created by 김윤수 on 2022/07/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var colors: [UIColor] = [.systemBlue, .systemIndigo, .systemPurple, .systemPink, .systemTeal]
    
    func cellConfiguration(book: Movie){
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = colors.randomElement()
        
        bookTitleLabel.text = book.title
        thumbnail.image = UIImage(named: "poster\(book.posterNumber)")
        rateLabel.text = "\(book.rate)"
        
        
    }
    
}
