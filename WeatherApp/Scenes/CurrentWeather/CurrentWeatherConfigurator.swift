//  
//  CurrentWeatherConfigurator.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

protocol CurrentWeatherConfigurator {
    func configure(_ controller: CurrentWeatherController)
}

class CurrentWeatherConfiguratorImpl: CurrentWeatherConfigurator {
    
    func configure(_ controller: CurrentWeatherController) {
        let router: CurrentWeatherRouter = CurrentWeatherRouterImpl(controller)
        
        let presenter: CurrentWeatherPresenter = CurrentWeatherPresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
