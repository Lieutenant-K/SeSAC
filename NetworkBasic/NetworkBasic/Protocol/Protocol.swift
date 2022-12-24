//
//  Protocol.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol {
    
    static var reuseIdentifier: String { get }
    
}

extension UIViewController: ReusableViewProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableViewProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

