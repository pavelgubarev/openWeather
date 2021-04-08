//
//  OpenWeatherDataDownloader.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation

enum WeatherServiceError : Error {
    case connectionError
    case parsingError
}

extension WeatherModel {
    
    
    func getCurrentWeatherFor(cityID : Int, completionHandler: @escaping (Result<WeatherData, WeatherServiceError>) -> Void) {
        
        let url = URL(string: self.dataURLBaseSting + "current?" +
            "&lat=" + cities[cityID].geo_lat +
            "&lon=" + cities[cityID].geo_long +
                        key )!
        
        let request = URLRequest(url: url)
                
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if error != nil {
                completionHandler(.failure(.connectionError))
                return
            }
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]  else {
                completionHandler(.failure(.parsingError))
                return
            }
                                    
            guard let jsonData = json["data"] as? [[String: AnyObject]] else {
                completionHandler(.failure(.parsingError))
                return
            }
            let jsonDataFirst = jsonData[0]
            guard let cityName = jsonDataFirst["city_name"] as? String else {
                completionHandler(.failure(.parsingError))
                return
            }
            guard let tempDouble = jsonDataFirst["temp"] as? Double else {
                completionHandler(.failure(.parsingError))
                return
            }
            let sky = SkyCondition.clear

            let weatherData = WeatherData(cityName: cityName, temp:tempDouble, sky: sky)

            DispatchQueue.main.async() {
                completionHandler(Result.success(weatherData))
            }

        }
        task.resume()
        
    }
    
    func getForecastFor(cityID : Int, completionHandler: @escaping (Result<FullForecast, WeatherServiceError>) -> Void) {
        
        let url = URL(string: self.dataURLBaseSting + "forecast/daily?" +
            "&lat=" + cities[cityID].geo_lat +
            "&lon=" + cities[cityID].geo_long
            + key )!
        
        let request = URLRequest(url: url)
                
        let task = URLSession.shared.dataTask(with: request) {data, response, error in

            var forecast = FullForecast()

            if error != nil {
                completionHandler(.failure(.connectionError))
                return
            }
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]  else {
                completionHandler(.failure(.parsingError))
                return
            }
        
            guard let jsonData = json["data"] as? [[String: AnyObject]] else { return }

            for oneDateForecast in jsonData {
                guard let dateString = oneDateForecast["valid_date"]  as? String else {
                    completionHandler(.failure(.parsingError))
                    return
                }
                let date = dateString.toDate(dateFormat: "yyyy-MM-dd")
                guard let temp = oneDateForecast["temp"] as? Double else {
                    completionHandler(.failure(.parsingError))
                    return
                }
                
                if date != nil {
                    forecast.append(ForecastOneDay(date: date!, temp: temp ))
                } else {
                    completionHandler(.failure(.parsingError))
                    return
                }
            }
            
            DispatchQueue.main.async() {
                completionHandler(Result.success(forecast))
            }
            
        }
        task.resume()
        
    }
    
    
}

extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date: Date? = dateFormatter.date(from: self)
        return date
    }
}
