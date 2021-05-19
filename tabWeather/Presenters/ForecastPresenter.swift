//
//  Presenter.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import CoreLocation

class ForecastPresenter {
    
    private let weatherModel : WeatherModel
    
    private var forecastViewDelegate : ForecastViewDelegate?
    private var parentPresenter : MainPresenterProtocol?
    
    init(withModel: WeatherModel) {
        self.weatherModel = withModel
    }
    
    func setViewDelegate(delegate : ForecastViewDelegate?) {
        self.forecastViewDelegate = delegate        
    }
    
    func setParent(presenter: MainPresenterProtocol) {
        self.parentPresenter = presenter
    }

    
    func updateForecast() {
        weatherModel.getForecastFor(cityID : weatherModel.currentCity, completionHandler: { (result) -> (Void)  in
            switch result {
                case .success(let forecastData):
                    self.forecastViewDelegate!.displayForecast(forecastData: forecastData)
                    self.weatherModel.saveForecast(forecastData: forecastData)
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async() {
                        self.parentPresenter?.displayConnectionError()
                    }
                    let forecastDataFromStorate = self.weatherModel.readForecast()
                    if forecastDataFromStorate.count > 0 {
                        DispatchQueue.main.async() {
                            self.forecastViewDelegate!.displayForecast(forecastData: forecastDataFromStorate)
                        }
                    }
            }

            
        })
    }
    
    func forecastDidAppear() {
        updateForecast()
    }
}
