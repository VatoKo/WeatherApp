//
//  WeatherIconGateway.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 19.08.21.
//

import Foundation

typealias WeatherIconGatewayCompletion = (_ result: Result<Data, Error>) -> Void

protocol WeatherIconGateway {
    func getIcon(with id: String, completion: @escaping WeatherIconGatewayCompletion)
}

class ApiWeatherIconGateway: WeatherIconGateway {
    
    func getIcon(with id: String, completion: @escaping WeatherIconGatewayCompletion) {
        DispatchQueue.global().async {
            if let url = URL(string: "https://openweathermap.org/img/wn/\(id)@2x.png"),
               let imageData = try? Data(contentsOf: url)
            {
                completion(.success(imageData))
            } else {
                completion(.failure(IconNotLoadedError()))
            }
        }
    }
}

struct IconNotLoadedError: Error {
    
}
