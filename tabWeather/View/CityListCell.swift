
//
//  OneCityCell.swift
//  yandexWeatherTestGubarev
//
//  Created by Павел Губарев on 19.01.2021.
//

import Foundation

import UIKit

class CityListCell: UITableViewCell {

    @IBOutlet private weak var cityName : UILabel!
    
    func set(cityName : String) {
        self.cityName.text = cityName
    }

}
