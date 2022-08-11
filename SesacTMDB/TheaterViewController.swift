//
//  TheaterViewController.swift
//  SesacTMDB
//
//  Created by 김윤수 on 2022/08/11.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self

        
    }
    

}

extension TheaterViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
    
    
}
