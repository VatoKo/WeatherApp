//  
//  ForecastController.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit
import CoreLocation

class ForecastController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    var locationManager: CLLocationManager = .init()
    
    var presenter: ForecastPresenter!
    
}

// MARK: UIViewController Lifecycle
extension ForecastController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ForecastConfiguratorImpl().configure(self)
        tableView.estimatedSectionHeaderHeight = 54
        tableView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellReuseIdentifier: ForecastCell.reuseIdentifier)
        tableView.register(UINib(nibName: "TitleHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: TitleHeaderView.reuseIdentifier)
        setupLocationManager()
        presenter.viewDidLoad()
    }
    
}

extension ForecastController: ForecastView {
    
    func setLoader(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func reloadList() {
        tableView.reloadData()
    }
    
    func setPageTitle(_ title: String) {
        self.title = title
    }
    
}

// MARK: UITableViewDelegate
extension ForecastController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = presenter.headerIdentifier(in: section)
        let dequeued = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        let header = dequeued as! ConfigurableCell
        presenter.configure(header: header, in: section)
        return dequeued
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
}

// MARK: UITableViewDataSource
extension ForecastController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = presenter.cellIdentifier(at: indexPath)
        let dequeued = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let cell = dequeued as! ConfigurableCell
        presenter.configure(cell: cell, at: indexPath)
        return dequeued
    }
    
}

// MARK: Location Access
extension ForecastController: LocationAccessible {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presenter.didFailToUpdateLocation(error: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        presenter.didUpdateLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
}
