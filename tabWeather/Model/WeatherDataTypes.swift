//
//  WeatherData.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

struct WeatherData {    
    var cityName: String
    var temp: Double
    var sky: SkyCondition
}

struct City: Encodable, Decodable {
    var id : Int
    var name: String
    var geo_lat: String
    var geo_long: String
}
