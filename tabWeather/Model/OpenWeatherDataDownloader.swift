//
//  OpenWeatherDataDownloader.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation


extension WeatherModel {
    
    func getCurrentWeatherFor(cityID : Int, completionHandler: @escaping CompletionHandler) {
        
        let url = URL(string: self.dataURLBaseSting + "current?" +
            "&lat=" + cities[cityID].geo_lat +
            "&lon=" + cities[cityID].geo_long +
                        key )!
        
        print(url)
        
        let request = URLRequest(url: url)
                
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]  else {
                return
            }
            
                        
            guard let jsonData = json["data"] as? [[String: AnyObject]] else { return }
            
            let jsonDataFirst = jsonData[0]
            
            guard let cityName = jsonDataFirst["city_name"] as? String else { return }
            guard let tempDouble = jsonDataFirst["temp"] as? Double else { return }
            let sky = SkyCondition.clear

            let weatherData = WeatherData(cityName: cityName, temp:String(tempDouble), sky: sky)

            DispatchQueue.main.async() {
                completionHandler(weatherData)
            }

        }
        task.resume()
        
    }
    
    func getForecastFor(cityID : Int, completionHandler: @escaping CompletionHandler) {
        
        let url = URL(string: self.dataURLBaseSting + "forecast/daily" +
            "&lat=" + cities[cityID].geo_lat +
            "&lon=" + cities[cityID].geo_long
            + key )!
        
        let request = URLRequest(url: url)
                
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]  else {
                return
            }
        
           print(json)
            
            
        }
        task.resume()
        
    }
    
    
}
