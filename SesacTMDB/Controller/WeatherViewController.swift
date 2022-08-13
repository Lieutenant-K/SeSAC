//
//  WheatherViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/13.
//

import UIKit
import CoreLocation

import Alamofire
import SwiftyJSON
import Kingfisher

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var localTitle: UILabel!
    @IBOutlet weak var tempButton: UIButton!
    @IBOutlet weak var humidityButton: UIButton!
    @IBOutlet weak var windButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    struct Weather {
        
        let temperature: Double
        let humidity: Int
        let wind: Int
        
    }
    
    let currentLocation: CLLocation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateSheetController()
        setTitle()
        fetchWeatherInfo()

        
    }
    
    func setTitle() {
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { placemarks, error in
            
            if let placemark = placemarks?.last {
                self.localTitle.text = "\(placemark.locality ?? "") \(placemark.subLocality ?? "")"
            }
        }
        
    }
    
    func fetchWeatherInfo() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentLocation.coordinate.latitude)&lon=\(currentLocation.coordinate.longitude)&appid=\(APIKey.wheatherKey)&units=metric"
        
        requestWeatherAPI(url: url) { item in
            
            let temp = item["main"]["temp"].doubleValue
            let humid = item["main"]["humidity"].intValue
            let wind = item["wind"]["speed"].doubleValue
            let image = item["weather"].arrayValue.first!["icon"].stringValue
            
            DispatchQueue.main.async {
                
                self.tempButton.setTitle("현재 온도는 \(temp)℃ 입니다", for: .normal)
                self.humidityButton.setTitle("현재 습도는 \(humid)% 입니다", for: .normal)
                self.windButton.setTitle("현재 풍속은 \(wind)m/s 입니다", for: .normal)
                self.imageView.kf.setImage(with: URL(string: "https://openweathermap.org/img/wn/\(image)@2x.png"))
            
            }
            
        }
        
    }
    
    
    func requestWeatherAPI(url: String, completionHandler: @escaping (JSON) -> Void) {
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print(json)
                completionHandler(json)
                
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func configurateSheetController() {
        
        guard let sheet = self.sheetPresentationController else { return }
        
        sheet.detents = [.medium(), .large()]
        sheet.largestUndimmedDetentIdentifier = .medium
        sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        sheet.prefersEdgeAttachedInCompactHeight = true
        sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        sheet.prefersGrabberVisible = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init?(coder: NSCoder, location: CLLocation) {
        self.currentLocation = location
        super.init(coder: coder)
    }

}
