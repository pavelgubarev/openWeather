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
}

struct City: Encodable, Decodable {
    var id : Int
    var name: String
    var geoLat: String
    var geoLong: String
}
