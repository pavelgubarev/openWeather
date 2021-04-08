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
        self.weatherViewDelegate?.displayLocationDenied()
    }
    
    func mainViewLoaded() {
        weatherViewDelegate!.setCities(withCities: weatherModel.cities)

        weatherViewDelegate!.setCurrentCity(cityID: 0)
    }
    
    func updateCurrentWeather() {
        weatherModel.getCurrentWeatherFor(cityID : weatherModel.currentCity, completionHandler: { (weatherData) -> (Void)  in            
            self.weatherViewDelegate!.displayWeather(weatherData: weatherData)
        })
    }
    
    func gotLocalLocation(location : CLLocationCoordinate2D) {
        
        weatherModel.setLocalLocation(lat: String(location.latitude), long: String(location.longitude))
        updateCurrentWeather()
    }
    
    func setNewLocalLocationAndUpdate() {
        weatherModel.setLocalLocation(lat: weatherModel.cities[weatherModel.currentCity].geo_lat, long: weatherModel.cities[weatherModel.currentCity].geo_long)
        updateCurrentWeather()
    }
    
    func didCitySelect(cityID : Int) {
        weatherModel.currentCity = cityID
        setNewLocalLocationAndUpdate()
    }
    
    func updateForecast() {
        weatherModel.getForecastFor(cityID : weatherModel.currentCity, completionHandler: { (forecastData) -> (Void)  in
            self.weatherViewDelegate!.displayForecast(forecastData: forecastData)
        })
    }
    
    func forecastDidAppear() {
        updateForecast()
    }
}
