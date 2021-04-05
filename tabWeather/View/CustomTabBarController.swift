//
//  CustomTabBarController.swift
//  tabWeather
//
//  Created by Павел Губарев on 05.04.2021.
//

import Foundation
import UIKit

class CustomTabBarController : UITabBarController {
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//            self.loadTabBar()
//        }
//
//    func loadTabBar() {
//            // We'll create and load our custom tab bar here
//        }
    
    
    override func viewDidLoad() {
        self.tabBar.items![0].image = UIImage(named: "weatherIcon")
        self.tabBar.items![0].imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 25, right: 0);
    }

    
}
