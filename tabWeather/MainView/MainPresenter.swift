//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

final class MainPresenter : ParentPresenterProtocol {
    
    private var model : Model
    private var mainViewDelegate : MainViewDelegate?
    private var citiesPresenter : CitiesPresenter?
    private var weatherPresenter : WeatherPresenter?

    init(withModel: Model) {
        self.model = withModel
    }
    
    func setViewDelegate(delegate : MainViewDelegate?) {
        self.mainViewDelegate = delegate
    }

    func setChildPresenters(citiesPresenter : CitiesPresenter, weatherPresenter : WeatherPresenter) {
        self.citiesPresenter = citiesPresenter
        self.weatherPresenter = weatherPresenter
    }
    
    func mainViewLoaded() {        
        citiesPresenter?.setCitiesList()
    }
    
    func setNewLocalLocationAndUpdate() {
        model.setLocalLocation(lat: model.cities[model.currentCity].geo_lat,
                                              long: model.cities[model.currentCity].geo_long)
        weatherPresenter?.updateCurrentWeather()
    }
    
    func displayConnectionError() {
        mainViewDelegate?.displayConnectionError()
    }
    
    func displayLocationDenied() {
        mainViewDelegate?.displayLocationDenied()
    }
    
    func gotLocalLocation(location : CLLocationCoordinate2D) {
        model.setLocalLocation(lat: String(location.latitude), long: String(location.longitude))
        weatherPresenter?.updateCurrentWeather()
    }
    
    func displayBlankWeather() {
        weatherPresenter?.displayBlankWeather()
    }
    
}
