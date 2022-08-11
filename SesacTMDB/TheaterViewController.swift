//
//  TheaterViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/11.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    
    enum TheaterType: String, CaseIterable {
        
        case lotte = "롯데시네마"
        case megabox = "메가박스"
        case cgv = "CGV"
        case all = "전체보기"
        
    }
    
    struct Theater {
        let type: TheaterType
        let location: String
        let latitude: Double
        let longitude: Double
    }

    
    let mapAnnotations: [Theater] = [
        Theater(type: .lotte, location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        Theater(type: .lotte, location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        Theater(type: .megabox, location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        Theater(type: .megabox, location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        Theater(type: .cgv, location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        Theater(type: .cgv, location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
    
   
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        title = "영화관 찾기"
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(touchFilterButton(_:)))
        self.navigationItem.rightBarButtonItem = filterButton
        
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        setRegionAndAnnotation(center: center)
        
        checkUserDeviceLocationAuthorization()

    }
    
    func checkUserDeviceLocationAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 켜짐")
            requestLocationAuthorization(status: authorizationStatus)
            
        } else {
            
            print("위치 서비스 해제됨")
            
        }
        
        
    }
    
    func requestLocationAuthorization(status: CLAuthorizationStatus) {
        
        switch status {
            
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            print("권한이 거절됐습니다.")
            showAuthorizationAlert()
        default:
            print("default")
        }
        
    }
    
    func showAuthorizationAlert() {
        
        let alert = UIAlertController(title: "위치 권한 거부됨", message: #"설정 > 앱 설정 > "위치"에서 권한을 허용해주세요"#, preferredStyle: .alert)
        
        let cancle = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: "설정으로 가기", style: .destructive) { _ in
            
            let url = URL(string: UIApplication.openSettingsURLString)!
            
            UIApplication.shared.open(url)
            
        }
        
        alert.addAction(cancle)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
        
        
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D){
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        
        mapView.setRegion(region, animated: true)
        
        mapAnnotations.forEach { theater in
            
            let annotation = MKPointAnnotation()
            annotation.title = theater.location
            annotation.coordinate = .init(latitude: theater.latitude, longitude: theater.longitude)
            mapView.addAnnotation(annotation)
        }
        
    }
    
    
    @objc func touchFilterButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(.init(title: "취소", style: .cancel))
        
        TheaterType.allCases.forEach { type in
            
            let action = UIAlertAction(title: type.rawValue, style: .default) { _ in
                
                self.mapView.removeAnnotations(self.mapView.annotations)
                
                self.mapView.showAnnotations(self.filterTheater(type: type), animated: true)
                
            }
            
            alert.addAction(action)
        }
        
        self.present(alert, animated: true)
        
    }
    
    func filterTheater(type: TheaterType) -> [MKPointAnnotation] {
        
        let annotations = (self.mapAnnotations.filter { $0.type == (type == .all ? $0.type : type)}).map { (item) -> MKPointAnnotation in
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = .init(latitude: item.latitude, longitude: item.longitude)
            annotation.title = item.location
            return annotation
        }
        
        return annotations
        
    }

}

extension TheaterViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        checkUserDeviceLocationAuthorization()
        
        print(#function)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        setRegionAndAnnotation(center: locations.last!.coordinate)
        
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    
}

extension TheaterViewController: MKMapViewDelegate {
    
    
    
    
}
