//
//  CellConfiguration.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

protocol ConfigurableCell {
    func configure(with model: CellModel)
}


protocol CellModel {
    var cellIdentifier: String { get }
}
