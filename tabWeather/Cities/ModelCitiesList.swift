//
//  ModelCitiesList.swift
//  yandexWeatherTestGubarev
//
//  Created by Павел Губарев on 19.01.2021.
//

import Foundation

extension Model {    
    func loadCities() {
     
            let url = Bundle.main.url(forResource: "cities", withExtension: "json")!
            do {
                let jsonData = try Data(contentsOf: url)
                self.cities = try JSONDecoder().decode([City].self, from: jsonData)
                
                let currentCityOption = City(id: 0, name: "Current city", geo_lat: "", geo_long: "")
                self.cities.insert(currentCityOption, at: 0)
            }
        
            catch {
                print(error)
            }
        
    }
}
