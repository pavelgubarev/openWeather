//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 20.05.2021.
//

import Foundation

class Presenter {
    
    let model : Model
    private(set) var parentPresenter : ParentPresenterProtocol?
    
    init(model: Model) {
        self.model = model
    }
    
    func setParent(presenter: ParentPresenterProtocol) {
        self.parentPresenter = presenter
    }
}
