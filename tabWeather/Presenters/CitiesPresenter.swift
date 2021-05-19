//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

class CitiesPresenter {
    
    private let weatherModel : WeatherModel
    
    private var viewDelegate : CitiesViewDelegate?
    
    private var parentPresenter : MainPresenterProtocol?
    
    init(withModel: WeatherModel) {
        self.weatherModel = withModel
    }
    
    func setViewDelegate(delegate : CitiesViewDelegate?) {
        self.viewDelegate = delegate        
    }
    
    func setParent(presenter: MainPresenterProtocol) {
        self.parentPresenter = presenter
    }
    
  
    func setCitiesList() {
        viewDelegate?.setCitiesList(withCities: weatherModel.cities)
        viewDelegate?.setCurrentCity(cityID: 0)
    }
    
    func didCitySelect(cityID : Int) {
         weatherModel.currentCity = cityID
        parentPresenter?.setNewLocalLocationAndUpdate()
     }
}
