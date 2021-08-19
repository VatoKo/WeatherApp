//
//  DoubleExtensions.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 19.08.21.
//

import Foundation

extension Double {
    
    var toCompassDirection: String {
        guard (0 ... 360) ~= self else { return "N/A"}
        let compassDirections = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW","N"]
        let value = self / 22.5
        let index = Int(value.rounded())
        return compassDirections[index]
    }
    
}
