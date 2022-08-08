//
//  ExpandedCell.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/08.
//

import UIKit

class ExpandableCell: UITableViewCell {
    
    let defaultLineNumber = 2
    var isExpanded = false {
        didSet {
            label.numberOfLines = isExpanded ? 0 : defaultLineNumber
            
            indicatorImageView.image = isExpanded ? .init(systemName: "chevron.up") : .init(systemName: "chevron.down")
            
        }
    }

    @IBOutlet weak var label: UILabel! {
        didSet {
            label.numberOfLines = defaultLineNumber
            label.textAlignment = .left
        }
    }
    
    
    @IBOutlet weak var indicatorImageView: UIImageView!
    
 
}
