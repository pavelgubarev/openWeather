//
//  WeatherModel.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

typealias CompletionHandler = (WeatherData) -> (Void) 

class WeatherModel : NSObject, CLLocationManagerDelegate {
    
    private weak var presenter : WeatherPresenter?
    
    private var locationManager: CLLocationManager?
    
    private var currentLocation: CLLocationCoordinate2D?
    
    let dataURLBaseSting = "https://api.openweathermap.org/data/2.5/"
    let key = "&appid=b18a5570e4f54a9befc80eb42ad0feef"    
        
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func setPresenter(withPresenter : WeatherPresenter) {
        presenter = withPresenter
    }
    
    func requestLocation() {
        locationManager?.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.presenter?.startGettingLocalWeather()
        } else {
            self.presenter?.displayLocationDenied()
        }
    }
    
    func getCurrentLocation() {
        locationManager?.startUpdatingLocation()
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if currentLocation == nil {
            let locValue : CLLocationCoordinate2D = manager.location!.coordinate
            currentLocation = locValue
            presenter?.gotLocalLocation(location : locValue)
        } else {
            locationManager?.stopUpdatingLocation()
        }
    }
}
