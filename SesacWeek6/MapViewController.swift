//
//  MapViewController.swift
//  SesacWeek6
//
//  Created by 김윤수 on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
//        checkUserDeviceLocationServiceAuthorization()
        setRegionAndAnnotation(center: CLLocationCoordinate2D(latitude: 37.550554, longitude: 127.074026))
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showRequestLocationServiceAlert()
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        // 지도 중심 설정
//        let center = CLLocationCoordinate2D(latitude: 37.550554, longitude: 127.074026)
        
        // 지도의 중심으로부터 보여질 범위
        let region =  MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
        
        // 지도에 핀 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "4년제 맛집"
        
        mapView.addAnnotation(annotation)
        
    }


}
// 위치 관련된 user defined 메서드
extension MapViewController {
    
    // 사용자 기기의 위치 서비스 활성화 여부 확인
    // 위치 서비스 Enable -> 권한 요청, Disable -> 알럿 띄워주기
    // - denied: 허용 안함 or 설정에서 거부 or 위치 서비스 사용안함 or 비행기 모드
    // - restricted: 자녀 보호 기능 등으로 제한됨
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스가 활성화 돼있으므로 위치 권한을 요청
            checkUserCurrentLocationAuthorization(authorizationStatus)
            
        } else {
            print("위치 서비스 비활성화")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            print("not determined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 앱 사용하는 동안에만 위치 권한 요청
            locationManager.requestWhenInUseAuthorization()

            //plist WhenInUs가 설정돼있어야 함.
//            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            print("denied, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("when in use")
            // 사용자가 위치 권한을 허용한 상태면 startUpdationLocation을 통해 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
        default:
            print("나머지")
        }
        
    }
    
    func showRequestLocationServiceAlert() {
        
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
        
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
          
          
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    // 사용자 위치를 성공적으로 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        // 위치 정보를 가지고 작업
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        
        
        
        locationManager.stopUpdatingLocation()
        
    }
    
    // 사용자의 위치를 못 가져온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
    }
    
    // 사용자의 권한 상태가 바뀔때 호출
    // 권한을 거부했다가 변경하거나 not Determined 상태에서 허용을 하는 경우
    // iOS 14이상 : 사용자 권한 상태 변경될 때, 위치 관리자가 생성될 때 호출됨.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    
}
