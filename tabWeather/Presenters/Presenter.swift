//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 20.05.2021.
//

import Foundation

class Presenter {
    
    let model : WeatherModel
    private(set) var parentPresenter : MainPresenterProtocol?

    
    init(withModel: WeatherModel) {
        self.model = withModel
    }
    
    func setParent(presenter: MainPresenterProtocol) {
        self.parentPresenter = presenter
    }
}
