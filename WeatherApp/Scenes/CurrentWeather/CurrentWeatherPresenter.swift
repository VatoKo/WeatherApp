//  
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit

protocol CurrentWeatherView: AnyObject {
    func setLoader(_ isLoading: Bool)
    func setWeatherIcon(image: UIImage?)
    func setLocationName(_ name: String)
    func setTemperatureDescription(_ description: String)
}

protocol CurrentWeatherPresenter {
    func viewDidLoad()
    func didUpdateLocation(latitude: Double, longitude: Double)
    func didFailToUpdateLocation(error: Error)
    func didTapShare()
}

class CurrentWeatherPresenterImpl: CurrentWeatherPresenter {
    
    private weak var view: CurrentWeatherView?
    private var router: CurrentWeatherRouter
    
    // MARK: Use cases
    private let currentWeatherUseCase: CurrentWeatherUseCase
    private let weatherIconUseCase: WeatherIconUseCase
    
    // MARK: Entities
    private var weatherData: WeatherResult?
    
    init(
        view: CurrentWeatherView,
        router: CurrentWeatherRouter,
        currentWeatherUseCase: CurrentWeatherUseCase,
        weatherIconUseCase: WeatherIconUseCase
    ) {
        self.view = view
        self.router = router
        self.currentWeatherUseCase = currentWeatherUseCase
        self.weatherIconUseCase = weatherIconUseCase
    }
    
    func viewDidLoad() {
        
    }
    
    private func configureView(with weatherData: WeatherResult) {
        if let iconId = weatherData.weather[0].icon {
            weatherIconUseCase.getIcon(with: iconId) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                        self.view?.setWeatherIcon(image: UIImage(data: imageData))
                    case .failure: break
                    }
                }
            }
        }
        self.view?.setLocationName(weatherData.name ?? "N/A")
        self.view?.setTemperatureDescription("\(Int(weatherData.main.temp))°C | \(weatherData.weather[0].main ?? "N/A")")
    }
    
}

// MARK: Location Updates
extension CurrentWeatherPresenterImpl {
    
    func didUpdateLocation(latitude: Double, longitude: Double) {
        view?.setLoader(true)
        currentWeatherUseCase.getWeather(for: latitude, and: longitude) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.setLoader(false)
                switch result {
                case .success(let weatherData):
                    self.weatherData = weatherData
                    self.configureView(with: weatherData)
                case .failure(let error):
                    print("Failed to fetch weather data: ", error.localizedDescription)
                }
            }
        }
    }
    
    func didFailToUpdateLocation(error: Error) {
        print("Failed to get location: ", error.localizedDescription)
    }
    
}

// MARK: Touch Events
extension CurrentWeatherPresenterImpl {
    
    func didTapShare() {
        guard let weatherData = weatherData else { return }
        let sheetText = "\(Int(weatherData.main.temp))°C | \(weatherData.weather[0].main ?? "N/A"), \(weatherData.name ?? "N/A") by WeatherApp"
        router.showShareSheet(with: sheetText)
    }
    
}

