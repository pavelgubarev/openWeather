//
//  WeatherViewController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

final class CitiesListViewController : UITableViewController, CitiesViewDelegate {

    private var cities : [City] = []
    private var currentCityId : Int = 0
    
    private weak var presenter: CitiesPresenter?
    
    func set(presenter : CitiesPresenter?) {
        self.presenter = presenter
    }
    
    func setCitiesList(withCities: [City]) {
        self.cities = withCities
    }
    
    func setCurrentCity(cityId: Int) {
        currentCityId = cityId
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .checkmark
            currentCityId = indexPath.row
            tableView.reloadData()
            presenter?.didCitySelect(cityID: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reusableCellID = "CityListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellID, for: indexPath)
        
        if let cityCell = cell as? CityListCell {
            cityCell.set(cityName: self.cities[indexPath.row].name)
            if indexPath.row == currentCityId  {
                cityCell.accessoryType = .checkmark
            } else {
                cityCell.accessoryType = .none
            }
            
            return cityCell            
        } else {
            return cell
        }
    }
    
}
