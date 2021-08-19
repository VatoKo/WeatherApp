//  
//  CurrentWeatherRouter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit

protocol CurrentWeatherRouter {
    func showShareSheet(with text: String)
}

class CurrentWeatherRouterImpl: CurrentWeatherRouter {
    
    private weak var controller: CurrentWeatherController?
    
    init(_ controller: CurrentWeatherController?) {
        self.controller = controller
    }
    
    func showShareSheet(with text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        controller?.present(activityViewController, animated: true, completion: nil)
    }
    
}
