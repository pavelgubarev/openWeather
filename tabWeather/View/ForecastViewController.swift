//
//  WeatherViewController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class ForecastViewController : UITableViewController {
    
    private weak var weatherPresenter : WeatherPresenter?
   
    func setPresenter(weatherPresenter : WeatherPresenter?) {
        self.weatherPresenter = weatherPresenter
    }
    
    override func viewDidAppear(_ animated: Bool) {
        weatherPresenter?.forecastDidAppear()
    }
}
