//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

class WeatherPresenter {
    
    private let weatherModel : WeatherModel
    
    private var weatherViewDelegate : ViewDelegate?
    
    init(withModel: WeatherModel) {
        self.weatherModel = withModel
        self.weatherModel.setPresenter(withPresenter: self)
    }
    
    func setViewDelegate(delegate : ViewDelegate?) {
        self.weatherViewDelegate = delegate
        
    }
    
    func onMainViewAppear() {
        
        weatherModel.requestLocation()
    }
    
    func startGettingLocalWeather() {
        weatherModel.getCurrentLocation()
    }
    
    func displayLocationDenied() {
        
    }
    
    func gotLocalLocation(location : CLLocationCoordinate2D) {
                
        let coords = Coords(lat: String(Int(location.latitude)), long: String(Int(location.longitude)))
        weatherModel.getCurrentWeatherFor(location: coords, completionHandler: { (weatherData) -> (Void)  in
                                          
            self.weatherViewDelegate!.displayWeather(weatherData: weatherData)
    })
    }
}
