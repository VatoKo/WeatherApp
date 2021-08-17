//
//  ForecastUseCase.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

typealias ForecastUseCaseCompletion = (_ result: Result<ForecastResult, Error>) -> Void

protocol ForecastUseCase {
    func getForecast(for latitude: Double, and longitude: Double, completion: @escaping ForecastUseCaseCompletion)
}

class ForecastUseCaseImpl: ForecastUseCase {
    
    private let gateway: ForecastGateway
    
    init(gateway: ForecastGateway) {
        self.gateway = gateway
    }
    
    func getForecast(for latitude: Double, and longitude: Double, completion: @escaping ForecastUseCaseCompletion) {
        gateway.getForecast(for: latitude, and: longitude, completion: completion)
    }
    
}
