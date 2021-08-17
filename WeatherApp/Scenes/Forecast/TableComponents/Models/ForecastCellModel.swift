//
//  ForecastCellModel.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

struct ForecastCellModel: CellModel {
    
    var cellIdentifier: String {
        return ForecastCell.reuseIdentifier
    }
    
    let iconId: String?
    let date: String
    let weatherDescription: String
    let degree: String
    
}
