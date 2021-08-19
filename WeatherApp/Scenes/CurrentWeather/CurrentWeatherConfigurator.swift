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
        
        let currentWeatherGateway: CurrentWeatherGateway = ApiCurrentWeatherGateway()
        let currentWeatherUseCase: CurrentWeatherUseCase = CurrentWeatherUseCaseImpl(gateway: currentWeatherGateway)
        
        let weatherIconGateway: WeatherIconGateway = ApiWeatherIconGateway()
        let weatherIconUseCase: WeatherIconUseCase = WeatherIconUseCaseImpl(gateway: weatherIconGateway)
        
        let presenter: CurrentWeatherPresenter = CurrentWeatherPresenterImpl(
            view: controller,
            router: router,
            currentWeatherUseCase: currentWeatherUseCase,
            weatherIconUseCase: weatherIconUseCase
        )
        
        controller.presenter = presenter
    }
    
}
