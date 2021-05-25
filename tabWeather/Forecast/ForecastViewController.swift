//
//  WeatherViewController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class ForecastViewController : UITableViewController, ForecastViewDelegate {
    
    private weak var presenter : ForecastPresenter?    
    var forecast = FullForecast()
    let formatter = DateFormatter()
    
    let cellReuseIdentifier = "ForecastOneCell"
    
    func set(presenter : ForecastPresenter?) {
        self.presenter = presenter
    }
    
    func displayForecast(forecastData: FullForecast) {
        forecast = forecastData
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        formatter.dateStyle = .short
        presenter?.forecastDidAppear()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        if let forecastCell = cell as? ForecastOneCell {
            forecastCell.date.text = formatter.string(from: forecast[indexPath.row].date)
            forecastCell.temperature.text = String(forecast[indexPath.row].temp) + "°"
            return forecastCell
        } else {            
            return cell
        }
    }
}
