//
//  ViewDelegate.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

protocol ViewDelegate {
    
    func displayLocationDenied()
    
    func displayWeather(weatherData: WeatherData)
    
}
