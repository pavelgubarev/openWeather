//
//  CustomTabBarController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class CustomTabBarController : UITabBarController, ViewDelegate {

    

    private let weatherPreseter = WeatherPresenter(withModel: WeatherModel())
    
    private var weatherVC : WeatherViewController?

    
    override func viewDidLoad() {
        
        weatherPreseter.setViewDelegate(delegate: self)
        
        self.tabBar.items![0].image = UIImage(named: "weatherIcon")
        self.tabBar.items![0].selectedImage = UIImage(named: "weatherSelected")
        self.tabBar.items![0].imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 25, right: 0)
        
        weatherVC = self.viewControllers?[0] as? WeatherViewController
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        weatherPreseter.onMainViewAppear()
    }
    
    
    func displayWeather(weatherData: WeatherData) {
        
        weatherVC?.displayWeather(weatherData: weatherData)
    }
    
    func displayLocationDenied() {
        weatherVC?.dislayLocationDenied()
    }
    
}
