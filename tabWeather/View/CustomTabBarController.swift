//
//  CustomTabBarController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class CustomTabBarController : UITabBarController, ViewDelegate {

    private let weatherPresenter = WeatherPresenter(withModel: WeatherModel())
    
    private weak var weatherVC : WeatherViewController?
    private weak var forecastVC : ForecastViewController?
    private weak var citySelectVC : CitiesListViewController?

    override func viewDidLoad() {
        
        weatherPresenter.setViewDelegate(delegate: self)
        
        self.tabBar.items![0].image = UIImage(named: "weatherIcon")
        self.tabBar.items![0].selectedImage = UIImage(named: "weatherSelected")
        self.tabBar.items![0].imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 25, right: 0)
        
        weatherVC = self.viewControllers?[0] as? WeatherViewController

        forecastVC = self.viewControllers?[1] as? ForecastViewController
        forecastVC!.setPresenter(weatherPresenter: weatherPresenter)
        
        citySelectVC = self.viewControllers?[2] as? CitiesListViewController
        citySelectVC!.setPresenter(weatherPresenter: weatherPresenter)
        
        
        weatherPresenter.mainViewLoaded()

    }

    
    override func viewDidAppear(_ animated: Bool) {
        weatherPresenter.onMainViewAppear()
    }
        
    func displayWeather(weatherData: WeatherData) {
        weatherVC?.displayWeather(weatherData: weatherData)
    }
    
    func displayForecast(forecastData: FullForecast) {
        forecastVC?.forecast = forecastData
        forecastVC?.tableView.reloadData()
    }
    
    func displayLocationDenied() {
        weatherVC?.dislayLocationDenied()
    }
    
    func displayConnectionError() {
        let refreshAlert = UIAlertController(title: "Connection Problem", message: "No internet or weather service problem. We'll try to show the latest data we have", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
             
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    func setCitiesList(withCities: [City]) {
        citySelectVC?.setCitiesList(withCities: withCities)
    }
    
    func setCurrentCity(cityID: Int) {
        citySelectVC!.setCurrentCity(cityID: cityID)
    }
    
    
}
