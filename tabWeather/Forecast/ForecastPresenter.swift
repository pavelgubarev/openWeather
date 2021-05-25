//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

class ForecastPresenter : Presenter {
    
    private var forecastViewDelegate : ForecastViewDelegate?
    
    func setViewDelegate(delegate : ForecastViewDelegate?) {
        self.forecastViewDelegate = delegate        
    }
    
    func updateForecast() {
        model.getForecastFor(cityID : model.currentCity, completionHandler: { [weak self] (result) -> (Void)  in
            switch result {
            
            case .success(let forecastData):
                self?.forecastViewDelegate!.displayForecast(forecastData: forecastData)
                self?.model.saveForecast(forecastData: forecastData)
            
            case .failure(let error):
                print(error)
                DispatchQueue.main.async() {
                    self?.parentPresenter?.displayConnectionError()
                }
                if let forecastDataFromStorage = self?.model.readForecast() {
                    if forecastDataFromStorage.count > 0 {
                        DispatchQueue.main.async() {
                            self?.forecastViewDelegate!.displayForecast(forecastData: forecastDataFromStorage)
                        }
                    }
                }
            }
            
        })
    }
    
    func forecastDidAppear() {
        updateForecast()
    }
    
}
