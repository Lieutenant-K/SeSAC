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

class WeatherViewController: UIViewController {
    
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
    
    @IBOutlet weak var degreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateSheetController()
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { placemarks, error in
            
            
            let placemark = placemarks?.first!
            /*
            print(placemark)
            print(placemark?.name)
            print(placemark?.country)
            print(placemark?.locality)
            print(placemark?.subLocality)
            print(placemark?.administrativeArea)
            print(placemark?.subAdministrativeArea)
            print(placemark?.location)
             */
            
            print(placemark?.thoroughfare)
            print(placemark?.subThoroughfare)
        }
        
        requestWeather { item in
            
            let temp = item["main"]["temp"].doubleValue
            let humid = item["main"]["humidity"].intValue
            let wind = item["wind"]["speed"].doubleValue
            
            DispatchQueue.main.async {
                
                self.tempButton.setTitle("현재 온도는 \(temp)℃ 입니다", for: .normal)
                self.humidityButton.setTitle("현재 습도는 \(humid)% 입니다", for: .normal)
                self.windButton.setTitle("현재 풍속은 \(wind)m/s 입니다", for: .normal)
                
                
            }
            
        }
        
    }
    
    func requestWeather(completionHandler: @escaping (JSON) -> Void) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentLocation.coordinate.latitude)&lon=\(currentLocation.coordinate.latitude)&appid=\(APIKey.wheatherKey)&lang=kr&units=metric"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init?(coder: NSCoder, location: CLLocation) {
        self.currentLocation = location
        super.init(coder: coder)
    }

}
