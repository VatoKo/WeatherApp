//
//  ForecastGateway.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

typealias ForecastGatewayCompletion = (_ result: Result<ForecastResult, Error>) -> Void

protocol ForecastGateway {
    func getForecast(for latitude: Double, and longitude: Double, completion: @escaping ForecastGatewayCompletion)
}

class ApiForecastGateway: ForecastGateway {
    
    func getForecast(for latitude: Double, and longitude: Double, completion: @escaping ForecastGatewayCompletion) {
        let apiKey = "5eaef40a803a177f4074102707d022ac"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(InvalidUrlError()))
            return
        }
        
        Fetcher<ForecastResult>.init(url: url).fetch(completion: completion)
    }
    
}

struct InvalidUrlError: Error {
    
}
