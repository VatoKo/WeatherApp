//  
//  CurrentWeatherController.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit
import CoreLocation

class CurrentWeatherController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var weatherIcon: UIImageView!
    @IBOutlet private weak var locationNameLabel: UILabel!
    @IBOutlet private weak var temperatureDescriptionLabel: UILabel!
    
    var locationManager: CLLocationManager = .init()
    
    var presenter: CurrentWeatherPresenter!
    
}

// MARK: UIViewController Lifecycle
extension CurrentWeatherController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentWeatherConfiguratorImpl().configure(self)
        setupLocationManager()
        presenter.viewDidLoad()
    }
    
}

extension CurrentWeatherController: CurrentWeatherView {
    
    func setLoader(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func setWeatherIcon(image: UIImage?) {
        weatherIcon.image = image
    }
    
    func setLocationName(_ name: String) {
        locationNameLabel.text = name
    }
    
    func setTemperatureDescription(_ description: String) {
        temperatureDescriptionLabel.text = description
    }
    
}

// MARK: Location Access
extension CurrentWeatherController: LocationAccessible {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presenter.didFailToUpdateLocation(error: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        presenter.didUpdateLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
}

