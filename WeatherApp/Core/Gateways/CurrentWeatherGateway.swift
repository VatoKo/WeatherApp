//
//  CurrentWeatherGateway.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 19.08.21.
//

import Foundation

typealias CurrentWeatherGatewayCompletion = (_ result: Result<WeatherResult, Error>) -> Void

protocol CurrentWeatherGateway {
    func getWeather(for latitude: Double, and longitude: Double, completion: @escaping CurrentWeatherGatewayCompletion)
}

class ApiCurrentWeatherGateway: CurrentWeatherGateway {
    
    
    func getWeather(for latitude: Double, and longitude: Double, completion: @escaping CurrentWeatherGatewayCompletion) {
        let apiKey = "5eaef40a803a177f4074102707d022ac"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(InvalidUrlError()))
            return
        }
        
        Fetcher<WeatherResult>.init(url: url).fetch(completion: completion)
    }
    
}
