//  
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit

struct CurrentWeatherViewModel {
    let locationName: String
    let temperatureDescription: String
    let cloudPercentage: String
    let humidity: String
    let pressure: String
    let windSpeed: String
    let windDirection: String
}

protocol CurrentWeatherView: AnyObject {
    func setContentVisibility(isHidden: Bool)
    func setLoader(_ isLoading: Bool)
    func setWeatherIcon(image: UIImage?)
    func configureView(with model: CurrentWeatherViewModel)
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
        view?.setContentVisibility(isHidden: true)
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
        view?.configureView(
            with: CurrentWeatherViewModel(
                locationName: weatherData.name ?? "-",
                temperatureDescription: "\(Int(weatherData.main.temp))°C | \(weatherData.weather[0].main ?? "-")",
                cloudPercentage: weatherData.clouds.all != nil ? "\(weatherData.clouds.all!) %" : "-",
                humidity: "\(weatherData.main.humidity) mm",
                pressure: "\(weatherData.main.pressure) hPa",
                windSpeed: weatherData.wind.speed != nil ? "\(weatherData.wind.speed!) km/h" : "-",
                windDirection: weatherData.wind.deg != nil ? weatherData.wind.deg!.toCompassDirection : "-"
            )
        )
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
                    self.view?.setContentVisibility(isHidden: false)
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
        let sheetText = "\(Int(weatherData.main.temp))°C | \(weatherData.weather[0].main ?? "-"), \(weatherData.name ?? "-") by WeatherApp"
        router.showShareSheet(with: sheetText)
    }
    
}

