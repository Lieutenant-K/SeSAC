//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by 김윤수 on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func request(){
        
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value).arrayValue[0]
//                print(json)
                self.nameLabel.text = json["name"].stringValue
                self.descriptionLabel.text = json["description"].stringValue
                
                let url = URL(string: json["image_url"].stringValue)
                self.imageView.kf.setImage(with: url)
                
            case .failure(let error):
                print(error)
            }
        }
    
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        
        request()
        
    }
    
    
    
}
