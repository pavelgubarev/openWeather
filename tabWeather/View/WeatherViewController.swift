//
//  WeatherViewController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class WeatherViewController : UIViewController {
    
    @IBOutlet weak var cityNameLabel : UILabel!
    @IBOutlet weak var tempLabel : UILabel!
    @IBOutlet weak var commentLabel : UILabel!

    func displayWeather(weatherData: WeatherData) {
        cityNameLabel.text = weatherData.cityName
        tempLabel.text = String(weatherData.temp)
        switch weatherData {
        case _ where weatherData.temp < 0 :
            commentLabel.text = "It's freezing!"
            break
        case _ where weatherData.temp > 0 && weatherData.temp < 15 :
            commentLabel.text = "It's cold!"
            break
        case _ where weatherData.temp >= 15 :
            commentLabel.text = "It's ok."
            break
        default:
            commentLabel.text = ""
        }
    }
    
    func displayBlankWeather() {
        cityNameLabel.text = "----"
        tempLabel.text = "-"
        commentLabel.text = "-"
    }
    
   
}
