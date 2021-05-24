
import Foundation
import CoreLocation

class WeatherPresenter : Presenter  {
    
    private var weatherViewDelegate : WeatherViewDelegate?
    
    func onWeatherViewAppear() {
        model.requestLocation()
    }
    
    func startGettingLocalWeather() {
        model.getCurrentLocation()
    }
    
    func setViewDelegate(delegate : WeatherViewDelegate?) {
        self.weatherViewDelegate = delegate
    }
    
    func updateCurrentWeather() {
        model.getCurrentWeatherFor(cityID : model.currentCity, completionHandler: { (result) -> (Void)  in
            switch result {
            case .success(let weatherData):
                self.weatherViewDelegate?.displayWeather(weatherData: weatherData)
            case .failure(let error):
                print(error)
                DispatchQueue.main.async() {
                    self.parentPresenter?.displayConnectionError()
                }
            }
            
        })
    }
    
    
    
    func setNewLocalLocationAndUpdate() {
        model.setLocalLocation(lat: model.cities[model.currentCity].geo_lat,
                               long: model.cities[model.currentCity].geo_long)
        updateCurrentWeather()
    }
    
    func displayBlankWeather() {
        weatherViewDelegate?.displayBlankWeather()
    }
    
}
