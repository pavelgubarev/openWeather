//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

final class CitiesPresenter : Presenter  {
    
    private var citiesViewDelegate : CitiesViewDelegate?
        
    func setViewDelegate(delegate : CitiesViewDelegate?) {
        self.citiesViewDelegate = delegate        
    }

    func setCitiesList() {
        
        citiesViewDelegate?.setCitiesList(withCities: model.cities)
        citiesViewDelegate?.setCurrentCity(cityId: 0)
    }
    
    func didCitySelect(cityID : Int) {
        model.currentCity = cityID
        parentPresenter?.setNewLocalLocationAndUpdate()
     }
}
