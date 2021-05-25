//
//  ModelCitiesList.swift
//  yandexWeatherTestGubarev
//
//  Created by Павел Губарев on 19.01.2021.
//

import Foundation

extension Model {    
    func loadCities() {
        guard cities.count == 0 else { return }
        let url = Bundle.main.url(forResource: "cities", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            cities = try JSONDecoder().decode([City].self, from: jsonData)
            let currentCityOption = City(id: 0, name: "Current city", geoLat: "", geoLong: "")
            cities.insert(currentCityOption, at: 0)
        } catch {
            print(error)
        }
        
    }
}
