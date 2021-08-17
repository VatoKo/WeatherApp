//  
//  CurrentWeatherRouter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

protocol CurrentWeatherRouter {
    
}

class CurrentWeatherRouterImpl: CurrentWeatherRouter {
    
    private weak var controller: CurrentWeatherController?
    
    init(_ controller: CurrentWeatherController?) {
        self.controller = controller
    }
    
}
