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
    @IBOutlet private weak var topSeparatorLine: UIView!
    @IBOutlet private weak var bottomSeparatorLine: UIView!
    
    private let rainbowLineColors: [UIColor] = [.purple, .orange, .green, .blue, .yellow, .red]
    
    private lazy var rainbowView: RainbowLineView = {
        let rainbowView = RainbowLineView(width: view.bounds.width, colors: rainbowLineColors)
        rainbowView.translatesAutoresizingMaskIntoConstraints = false
        return rainbowView
    }()
    
    var locationManager: CLLocationManager = .init()
    
    var presenter: CurrentWeatherPresenter!
    
}

// MARK: UIViewController Lifecycle
extension CurrentWeatherController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentWeatherConfiguratorImpl().configure(self)
        setupRainbowLine()
        setupSeparatorLines()
        setupLocationManager()
        presenter.viewDidLoad()

    }
    
}

// MARK: UIViewController Rotation
extension CurrentWeatherController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        rainbowView.reset()
        rainbowView.setup(width: size.width, colors: rainbowLineColors)
    }
    
}

// MARK: Setup
extension CurrentWeatherController {
    
    private func setupRainbowLine() {
        view.addSubview(rainbowView)
        NSLayoutConstraint.activate([
            rainbowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            rainbowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rainbowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rainbowView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupSeparatorLines() {
        drawDottedLine(
            start: CGPoint(x: topSeparatorLine.bounds.minX, y: topSeparatorLine.bounds.minY),
            end: CGPoint(x: topSeparatorLine.bounds.maxX, y: topSeparatorLine.bounds.minY),
            view: topSeparatorLine,
            color: .gray
        )
        drawDottedLine(
            start: CGPoint(x: bottomSeparatorLine.bounds.minX, y: bottomSeparatorLine.bounds.minY),
            end: CGPoint(x: bottomSeparatorLine.bounds.maxX, y: bottomSeparatorLine.bounds.minY),
            view: bottomSeparatorLine,
            color: .gray
        )
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

// MARK: Dotted line draw helper
extension CurrentWeatherController {
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView, color: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [3, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
}

