import UIKit

let mainTabBarInsets = UIEdgeInsets(top: 0, left: -10, bottom: 25, right: 0)

final class MainTabBarController : UITabBarController, MainViewDelegate {
    
    lazy var weatherIcon = UIImage(named: "weatherIcon")
    lazy var weatherIconSelected = UIImage(named: "weatherSelected")
    
    private weak var weatherVC : WeatherViewController?
    private weak var forecastVC : ForecastViewController?
    private weak var citySelectVC : CitiesListViewController?
    
    private let architecture = ArchitectureAssembler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.items?[0].image = weatherIcon
        tabBar.items?[0].selectedImage = weatherIconSelected
        tabBar.items?[0].imageInsets = mainTabBarInsets
        
        architecture.assemble()
        assembleViews()
        
        architecture.mainPresenter.mainViewLoaded()        
    }
    
    func assembleViews() {
        
        weatherVC = self.viewControllers?[0] as? WeatherViewController
        architecture.weatherPresenter.setViewDelegate(delegate: weatherVC)
        weatherVC?.set(presenter: architecture.weatherPresenter)
        
        forecastVC = self.viewControllers?[1] as? ForecastViewController
        forecastVC?.set(presenter: architecture.forecastPresenter)
        architecture.forecastPresenter.setViewDelegate(delegate: forecastVC)
        
        citySelectVC = self.viewControllers?[2] as? CitiesListViewController
        citySelectVC?.set(presenter: architecture.citiesPresenter)
        architecture.citiesPresenter.setViewDelegate(delegate: citySelectVC)
        
//        let controllerToPresenter  = [weatherVC : architecture.weatherPresenter,
//                                      weatherVC : architecture.forecastPresenter,
//                                      citySelectVC : architecture.citiesPresenter]
        
        
    }
    
    
    func displayConnectionError() {
        let refreshAlert = UIAlertController(title: "Connection Problem",
                                             message: "No internet or weather service problem. We'll try to show the latest data we have",
                                             preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    func displayLocationDenied() {
        let refreshAlert = UIAlertController(title: "Location is not available",
                                             message: "Please allow location in settings.",
                                             preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.architecture.mainPresenter.displayBlankWeather()             
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
}
