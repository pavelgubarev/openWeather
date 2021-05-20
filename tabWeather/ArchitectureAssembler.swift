//
//  ArchitectureAssembler.swift
//  tabWeather
//
//  Created by Павел Губарев on 20.05.2021.
//

import Foundation

class ArchitectureAssembler {
    
    let mainPresenter = MainPresenter(withModel: WeatherModel())
    let weatherPresenter = WeatherPresenter(withModel: WeatherModel())
    let forecastPresenter = ForecastPresenter(withModel: WeatherModel())
    let citiesPresenter = CitiesPresenter(withModel: WeatherModel())
    
    func assemble() {
        _ = [citiesPresenter, forecastPresenter, weatherPresenter].map{ $0.setParent(presenter: mainPresenter)}
        
        mainPresenter.setChildPresenters(citiesPresenter: citiesPresenter, weatherPresenter: weatherPresenter)
        
    }
}
