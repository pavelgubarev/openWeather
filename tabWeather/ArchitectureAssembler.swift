//
//  ArchitectureAssembler.swift
//  tabWeather
//
//  Created by Павел Губарев on 20.05.2021.
//

import Foundation

class ArchitectureAssembler {
    
    var mainPresenter : MainPresenter!
    var weatherPresenter : WeatherPresenter!
    var forecastPresenter : ForecastPresenter!
    var citiesPresenter : CitiesPresenter!
    
    func assemble() {
        let model = Model()
        
        mainPresenter = MainPresenter(withModel: model)
        weatherPresenter = WeatherPresenter(withModel: model)
        forecastPresenter = ForecastPresenter(withModel: model)
        citiesPresenter = CitiesPresenter(withModel: model)
        
        _ = [citiesPresenter, forecastPresenter, weatherPresenter].map{ $0.setParent(presenter: mainPresenter)}
        
        model.setPresenter(withPresenter: mainPresenter)
        
        mainPresenter.setChildPresenters(citiesPresenter: citiesPresenter, weatherPresenter: weatherPresenter)
        
    }
}
