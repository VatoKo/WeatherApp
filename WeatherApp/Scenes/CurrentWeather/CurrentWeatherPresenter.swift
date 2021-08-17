//  
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

protocol CurrentWeatherView: AnyObject {
    
}

protocol CurrentWeatherPresenter {
    
}

class CurrentWeatherPresenterImpl: CurrentWeatherPresenter {
    
    private weak var view: CurrentWeatherView?
    private var router: CurrentWeatherRouter
    
    init(view: CurrentWeatherView, router: CurrentWeatherRouter) {
        self.view = view
        self.router = router
    }
}
