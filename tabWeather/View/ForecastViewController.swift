//
//  WeatherViewController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class ForecastViewController : UITableViewController {
    
    private weak var presenter : ForecastPresenter?
    
    var forecast = FullForecast()
    
    let formatter = DateFormatter()
    
    func setForecast(withForecast : FullForecast) {
        self.forecast = withForecast
    }
    
    func set(presenter : ForecastPresenter?) {
        self.presenter = presenter
    }
    
    override func viewDidAppear(_ animated: Bool) {
        formatter.dateStyle = .short
        presenter?.forecastDidAppear()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastOneCell", for: indexPath) as! ForecastOneCell
        
        cell.date.text = formatter.string(from: forecast[indexPath.row].date)
        cell.temperature.text = String(forecast[indexPath.row].temp) + "°"

        return cell
        
    }
}
