//
//  ArchitectureAssembler.swift
//  tabWeather
//
//  Created by Павел Губарев on 20.05.2021.
//

import Foundation

class ArchitectureAssembler {
    
    let model = Model()
    
    lazy var mainPresenter : MainPresenter = MainPresenter(model: model)
    lazy var weatherPresenter : WeatherPresenter = WeatherPresenter(model: model)
    lazy var forecastPresenter : ForecastPresenter = ForecastPresenter(model: model)
    lazy var citiesPresenter : CitiesPresenter = CitiesPresenter(model: model)
    
    func assemble() {
        
        for presenter in [citiesPresenter, forecastPresenter, weatherPresenter] { presenter.setParent(presenter: mainPresenter)
        }
        
        model.setPresenter(withPresenter: mainPresenter)
        
        mainPresenter.setChildPresenters(citiesPresenter: citiesPresenter, weatherPresenter: weatherPresenter)
        
    }
}
