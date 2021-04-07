//
//  WeatherViewController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class CitiesListViewController : UITableViewController {
    
    private var cities = [City]()
    private var currentCityID : Int = 0
    
    private weak var weatherPresenter : WeatherPresenter?
   
    func setPresenter(weatherPresenter : WeatherPresenter?) {
        self.weatherPresenter = weatherPresenter
    }
    
    func setCities(withCities : [City]) {
        self.cities = withCities
    }
    
    func setCurrentCity(cityID: Int) {
        currentCityID = cityID
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .checkmark
            currentCityID = indexPath.row
            tableView.reloadData()
            weatherPresenter?.didCitySelect(cityID: indexPath.row)
        }
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell", for: indexPath) as! CityListCell
        
        cell.cityName.text = self.cities[indexPath.row].name
        
        if indexPath.row == currentCityID  {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
                
        return cell
        
    }
    
}