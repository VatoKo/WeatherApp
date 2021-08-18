//
//  TitleHeaderViewModel.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 18.08.21.
//

import Foundation

struct TitleHeaderViewModel: CellModel {
    
    var cellIdentifier: String {
        return TitleHeaderView.reuseIdentifier
    }
    
    let title: String
    
}
