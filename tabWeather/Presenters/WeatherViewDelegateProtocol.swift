//
//  ViewDelegate.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

protocol WeatherViewDelegate {
    
    func displayWeather(weatherData: WeatherData)

    func displayLocationDenied()
    
    func displayConnectionError()
    
    func displayBlankWeather()

}
