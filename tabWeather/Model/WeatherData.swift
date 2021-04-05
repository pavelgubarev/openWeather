//
//  WeatherData.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

enum SkyCondition {
    case rain
    case snow
    case clear
    case clouds
}

struct WeatherData {    
    var cityName: String
    var temp: String
    var sky: SkyCondition
}
