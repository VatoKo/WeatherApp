//  
//  ForecastRouter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

protocol ForecastRouter {
    
}

class ForecastRouterImpl: ForecastRouter {
    
    private weak var controller: ForecastController?
    
    init(_ controller: ForecastController?) {
        self.controller = controller
    }
    
}
