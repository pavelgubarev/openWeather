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

    
    init(withModel: Model) {
        self.model = withModel
    }
    
    func setParent(presenter: ParentPresenterProtocol) {
        self.parentPresenter = presenter
    }
}
