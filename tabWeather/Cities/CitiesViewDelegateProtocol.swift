//
//  ViewDelegate.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

protocol CitiesViewDelegate {
    
    func setCitiesList(withCities: [City])
    
    func setCurrentCity(cityId: Int)

}
