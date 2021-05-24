//
//  MainPresenterProtocol.swift
//  tabWeather
//
//  Created by Павел Губарев on 19.05.2021.
//

import Foundation

protocol ParentPresenterProtocol {
    
    func setNewLocalLocationAndUpdate()
    
    func displayConnectionError()
    
}
