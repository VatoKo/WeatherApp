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
    @IBOutlet private weak var contentContainerStack: UIStackView!
    @IBOutlet private weak var weatherIcon: UIImageView!
    @IBOutlet private weak var locationNameLabel: UILabel!
    @IBOutlet private weak var temperatureDescriptionLabel: UILabel!
    @IBOutlet private weak var cloudPercentageLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var windDirectionLabel: UILabel!
    
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
    
    func setContentVisibility(isHidden: Bool) {
        contentContainerStack.isHidden = isHidden
    }
    
    func setLoader(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func setWeatherIcon(image: UIImage?) {
        weatherIcon.image = image
    }
    
    func configureView(with model: CurrentWeatherViewModel) {
        locationNameLabel.text = model.locationName
        temperatureDescriptionLabel.text = model.temperatureDescription
        cloudPercentageLabel.text = model.cloudPercentage
        humidityLabel.text = model.humidity
        pressureLabel.text = model.pressure
        windSpeedLabel.text = model.windSpeed
        windDirectionLabel.text = model.windDirection
    }
    
}

// MARK: Touch Events
extension CurrentWeatherController {
    
    @IBAction
    private func didTapShare() {
        presenter.didTapShare()
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

