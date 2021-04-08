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
    
    func displayBlankWeather() {
        cityName.text = "----"
        temp.text = "-"
    }
    
    func dislayLocationDenied() {
        let refreshAlert = UIAlertController(title: "Location is not available", message: "Please allow location in settings.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            self.displayBlankWeather()
             
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
}
