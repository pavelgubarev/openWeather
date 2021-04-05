//
//  WeatherViewController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class WeatherViewController : UIViewController {
    
    @IBOutlet weak var cityName : UILabel!
    @IBOutlet weak var temp : UILabel!

    func displayWeather(weatherData: WeatherData) {
        cityName.text = weatherData.cityName
        temp.text = weatherData.temp
    }
    
    func dislayLocationDenied() {
        
    }
    
}
