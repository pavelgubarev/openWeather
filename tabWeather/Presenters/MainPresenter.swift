//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

class MainPresenter : MainPresenterProtocol {
    
    private let weatherModel : WeatherModel
    
    private var mainViewDelegate : MainViewDelegate?

    init(withModel: WeatherModel) {
        self.weatherModel = withModel
    }
    
    func setViewDelegate(delegate : MainViewDelegate?) {
        self.mainViewDelegate = delegate
    }
    
    var citiesPresenter : CitiesPresenter?
    var weatherPresenter : WeatherPresenter?

    func setChildPresenters(citiesPresenter : CitiesPresenter, weatherPresenter : WeatherPresenter) {
        self.citiesPresenter = citiesPresenter
        self.weatherPresenter = weatherPresenter
    }
    
    func mainViewLoaded() {
        citiesPresenter?.setCitiesList()
    }
    
    func displayBlankWeather() {
        weatherPresenter?.displayBlankWeather()
    }
    
    func setNewLocalLocationAndUpdate() {
    }
    
    func displayConnectionError() {
        mainViewDelegate?.displayConnectionError()
    }
    
    func displayLocationDenied() {
        mainViewDelegate?.displayLocationDenied()
    }
    
    
}
