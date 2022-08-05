//
//  Extension.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/04.
//

import UIKit

protocol ReusableView {
    
    static var reuseIdentifier: String { get }
    
}

protocol DisplayInCell {
    var titleText: String { get }
    var subText: String { get }
    var imagePath: String { get }
}

extension UIViewController: ReusableView {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
}

extension UITableViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
}

extension UICollectionViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
}
