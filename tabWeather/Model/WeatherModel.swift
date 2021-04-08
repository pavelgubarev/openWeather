//
//  WeatherModel.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

struct forecastOneDay {
    var date : Date
    var temp : Double
}

typealias FullForecast = [forecastOneDay]

typealias CompletionHandlerWeatherData = (WeatherData) -> (Void)
typealias CompletionHandlerForecast = (FullForecast) -> (Void)


class WeatherModel : NSObject, CLLocationManagerDelegate {
    
    private weak var presenter : WeatherPresenter?
    
    private var locationManager: CLLocationManager?
    
    private var currentLocation: CLLocationCoordinate2D?

    var currentCity : Int = 0
    
    var cities = [City]()
    
    let dataURLBaseSting = "https://api.weatherbit.io/v2.0/"
    let key = "&key=ff7cd68bcfa94069a7027691119b8e29"
        
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        self.loadCities()
    }
    
    func setLocalLocation(lat: String, long: String) {
        let updatedLocalCity = City(id: 0, name: cities[0].name, geo_lat: lat, geo_long: long)
        cities[0] = updatedLocalCity
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
