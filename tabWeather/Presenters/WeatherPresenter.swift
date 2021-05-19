
import Foundation
import CoreLocation

class WeatherPresenter  {
    
    private let weatherModel : WeatherModel
    
    private var weatherViewDelegate : WeatherViewDelegate?
    
    init(withModel: WeatherModel) {
        self.weatherModel = withModel
    }
        
    func onWeatherViewAppear() {
        weatherModel.requestLocation()
    }
    
    func startGettingLocalWeather() {
        weatherModel.getCurrentLocation()
    }
    

    func updateCurrentWeather() {
        weatherModel.getCurrentWeatherFor(cityID : weatherModel.currentCity, completionHandler: { (result) -> (Void)  in
            
        switch result {
            case .success(let weatherData):
                self.weatherViewDelegate!.displayWeather(weatherData: weatherData)
            case .failure(let error):
                print(error)
                DispatchQueue.main.async() {
                    self.weatherViewDelegate?.displayConnectionError()
                }
        }
        
        })
    }
    
    func gotLocalLocation(location : CLLocationCoordinate2D) {
        
        weatherModel.setLocalLocation(lat: String(location.latitude), long: String(location.longitude))
        updateCurrentWeather()
    }
    
    func setNewLocalLocationAndUpdate() {
        weatherModel.setLocalLocation(lat: weatherModel.cities[weatherModel.currentCity].geo_lat,
                                      long: weatherModel.cities[weatherModel.currentCity].geo_long)
        updateCurrentWeather()
    }
    
    func displayBlankWeather() {
        weatherViewDelegate?.displayBlankWeather()
    }
   
}
