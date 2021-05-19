//
//  CustomTabBarController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class MainTabBarController : UITabBarController, MainViewDelegate {


    

    private let mainPresenter = MainPresenter(withModel: WeatherModel())
    private let weatherPresenter = WeatherPresenter(withModel: WeatherModel())
    private let forecastPresenter = ForecastPresenter(withModel: WeatherModel())
    private let citiesPresenter = CitiesPresenter(withModel: WeatherModel())

    private weak var weatherVC : WeatherViewController?
    private weak var forecastVC : ForecastViewController?
    private weak var citySelectVC : CitiesListViewController?
    
    
    func buildArchitecture() {
        
        citiesPresenter.setParent(presenter: mainPresenter)
        forecastPresenter.setParent(presenter: mainPresenter)
        
        mainPresenter.setChildPresenters(citiesPresenter: citiesPresenter, weatherPresenter: weatherPresenter)
        
        weatherVC = self.viewControllers?[0] as? WeatherViewController

        forecastVC = self.viewControllers?[1] as? ForecastViewController
        forecastVC!.set(presenter: forecastPresenter)
        
        citySelectVC = self.viewControllers?[2] as? CitiesListViewController
        citySelectVC!.set(presenter: citiesPresenter)
        
    }

    override func viewDidLoad() {
        
        self.tabBar.items![0].image = UIImage(named: "weatherIcon")
        self.tabBar.items![0].selectedImage = UIImage(named: "weatherSelected")
        self.tabBar.items![0].imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 25, right: 0)
        
        mainPresenter.mainViewLoaded()

    }

  
    
    func displayConnectionError() {
        let refreshAlert = UIAlertController(title: "Connection Problem", message: "No internet or weather service problem. We'll try to show the latest data we have", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
             
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    

    func displayLocationDenied() {
        let refreshAlert = UIAlertController(title: "Location is not available", message: "Please allow location in settings.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            self.mainPresenter.displayBlankWeather()
             
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    
}
