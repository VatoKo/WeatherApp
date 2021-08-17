//  
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

protocol ForecastView: AnyObject {
    
}

protocol ForecastPresenter {
    
}

class ForecastPresenterImpl: ForecastPresenter {
    
    private weak var view: ForecastView?
    private var router: ForecastRouter
    
    init(view: ForecastView, router: ForecastRouter) {
        self.view = view
        self.router = router
    }
}
