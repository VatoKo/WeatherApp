//  
//  ForecastController.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit

class ForecastController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: ForecastPresenter!

    
}

// MARK: UIViewController Lifecycle
extension ForecastController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ForecastConfiguratorImpl().configure(self)
        tableView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellReuseIdentifier: ForecastCell.reuseIdentifier)
        presenter.viewDidLoad()
    }
    
}

extension ForecastController: ForecastView {
    
    func reloadList() {
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForHeader(in: section)
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
