//
//  CurrentWeatherUseCase.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 19.08.21.
//

import Foundation

typealias CurrentWeatherUseCaseCompletion = (_ result: Result<WeatherResult, Error>) -> Void

protocol CurrentWeatherUseCase {
    func getWeather(for latitude: Double, and longitude: Double, completion: @escaping CurrentWeatherUseCaseCompletion)
}

class CurrentWeatherUseCaseImpl: CurrentWeatherUseCase {
    
    private let gateway: CurrentWeatherGateway
    
    init(gateway: CurrentWeatherGateway) {
        self.gateway = gateway
    }
    
    func getWeather(for latitude: Double, and longitude: Double, completion: @escaping CurrentWeatherUseCaseCompletion) {
        gateway.getWeather(for: latitude, and: longitude, completion: completion)
    }
}
