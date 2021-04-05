//
//  OpenWeatherDataDownloader.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

struct Coords {
    var lat: String
    var long: String
}


extension WeatherModel {
    
    func getCurrentWeatherFor(location : Coords, completionHandler: @escaping CompletionHandler) {
        
        let url = URL(string: self.dataURLBaseSting + "weather?&units=metric" + "&lat=" + String(location.lat) +
            "&lon=" + String(location.long) + key )!
                
        let request = URLRequest(url: url)
                
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]  else {
                return
            }
            
            
            guard let cityName = json["name"] as? String else { return }
            
            guard let mainInfo = json["main"] as? [String: Any] else { return }
             
            guard let tempFloat = mainInfo["temp_min"] as? Double else { print(mainInfo); return }
            
            let temp = String(tempFloat)

            let sky = SkyCondition.clear
            
            let weatherData = WeatherData(cityName: cityName, temp: temp, sky: sky)
            
            DispatchQueue.main.async() {
                completionHandler(weatherData)
            }
            
        }
        task.resume()
        
    }
    
    
}
