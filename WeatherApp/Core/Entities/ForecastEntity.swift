//
//  ForecastEntity.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

struct ForecastResult: Codable {
    let cod: String
    let message: Int
    let list: [Forecast]
    let city: ForecastCity
}

struct Forecast: Codable {
    let dt: Int64
    let main: ForecastMain
    let weather: [Weather]
    let dt_txt: String
}

struct ForecastMain: Codable {
    let temp: Double
    let feel: Double
    let pressure: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelLike = "feels_like"
        case pressure
        case humidity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try container.decode(Double.self, forKey: .temp)
        feel = try container.decode(Double.self, forKey: .feelLike)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try container.decode(Double.self, forKey: .humidity)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temp, forKey: .temp)
        try container.encode(feel, forKey: .feelLike)
        try container.encode(pressure, forKey: .pressure)
        try container.encode(humidity, forKey: .humidity)
    }
}

struct ForecastCity: Codable {
    let name: String
    let country: String
}

struct Weather: Codable {
    let main: String?
    let description: String?
    let icon: String?
}
