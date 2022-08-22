//
//  SearchTableViewCell.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/07/27.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var totalAudienceLabel: UILabel!
    
    func configurateContent(data: BoxOfficeModel) {
        
        let count = Int(data.totalCount)!.formatted(IntegerFormatStyle.number)
        
        self.titleLabel.text = data.movieTitle
        self.releaseDateLabel.text = "개봉일: \(data.releaseDate)"
        self.totalAudienceLabel.text = "누적 관객수: \(count)명"
        
        
    }
}
