//
//  CurrentWeatherEntity.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 19.08.21.
//

import Foundation

struct WeatherResult: Codable {
    let cod: Int
    let name: String?
    let wind: Wind
    let main: ForecastMain
    let weather: [Weather]
    let clouds: Cloud
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
}

struct Cloud: Codable {
    let all: Int?
}
