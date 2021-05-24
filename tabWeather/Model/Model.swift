//
//  Model.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation
import CoreData

struct ForecastOneDay {
    var date : Date
    var temp : Double
}

typealias FullForecast = [ForecastOneDay]


final class Model : NSObject, CLLocationManagerDelegate {
    
    private weak var mainPresenter : MainPresenter?
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocationCoordinate2D?
    var currentCity : Int = 0
    var cities = [City]()
    
    var managedContext : NSManagedObjectContext!
        
    let dataURLBaseSting = "https://api.weatherbit.io/v2.0/"
    let key = "&key=ff7cd68bcfa94069a7027691119b8e29"
        
    override init() {
        super.init()
        
        initCoreData()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        self.loadCities()
    }
    
    func setLocalLocation(lat: String, long: String) {
        
        let updatedLocalCity = City(id: 0, name: cities[0].name, geo_lat: lat, geo_long: long)
        cities[0] = updatedLocalCity
    }
    
    func setPresenter(withPresenter : MainPresenter) {
        mainPresenter = withPresenter
    }
    
    func requestLocation() {
        locationManager?.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                break
            case .authorizedWhenInUse, .authorizedAlways:
                self.getCurrentLocation()
                break
            case .restricted, .denied:
                self.mainPresenter?.displayLocationDenied()
                break
            @unknown default:
                break
            }
        }
    
    func getCurrentLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation == nil {
            let locValue : CLLocationCoordinate2D = manager.location!.coordinate
            currentLocation = locValue
            mainPresenter?.gotLocalLocation(location : locValue)
        } else {
            locationManager?.stopUpdatingLocation()
        }
    }
}
