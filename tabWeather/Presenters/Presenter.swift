//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 20.05.2021.
//

import Foundation

class Presenter {
    
    let model : WeatherModel
    private(set) var parentPresenter : ParentPresenterProtocol?

    
    init(withModel: WeatherModel) {
        self.model = withModel
    }
    
    func setParent(presenter: ParentPresenterProtocol) {
        self.parentPresenter = presenter
    }
}
