//
//  ViewDelegate.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

protocol ViewDelegate {
    
    func displayWeather(weatherData: WeatherData)

    func displayForecast(forecastData: FullForecast)

    func setCitiesList(withCities: [City])
    
    func setCurrentCity(cityID: Int)

    func displayLocationDenied()
    
    func displayConnectionError()

}
