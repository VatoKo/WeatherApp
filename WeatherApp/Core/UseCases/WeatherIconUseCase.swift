//
//  WeatherIconUseCase.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 19.08.21.
//

import Foundation

typealias WeatherIconUseCaseCompletion = (_ result: Result<Data, Error>) -> Void

protocol WeatherIconUseCase {
    func getIcon(with id: String, completion: @escaping WeatherIconUseCaseCompletion)
}

class WeatherIconUseCaseImpl: WeatherIconUseCase {
    
    private let gateway: WeatherIconGateway
    
    init(gateway: WeatherIconGateway) {
        self.gateway = gateway
    }
    
    func getIcon(with id: String, completion: @escaping WeatherIconUseCaseCompletion) {
        gateway.getIcon(with: id, completion: completion)
    }
    
}
