//  
//  ForecastConfigurator.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

protocol ForecastConfigurator {
    func configure(_ controller: ForecastController)
}

class ForecastConfiguratorImpl: ForecastConfigurator {
    
    func configure(_ controller: ForecastController) {
        let router: ForecastRouter = ForecastRouterImpl(controller)
        
        let forecastGateway: ForecastGateway = ApiForecastGateway()
        let forecastUseCase: ForecastUseCase = ForecastUseCaseImpl(gateway: forecastGateway)
        
        let presenter: ForecastPresenter = ForecastPresenterImpl(
            view: controller,
            router: router,
            forecastUseCase: forecastUseCase
        )
        
        controller.presenter = presenter
    }
    
}
