//  
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

struct SectionModel {
    let title: String
    let cells: [CellModel]
}

protocol ForecastView: AnyObject {
    func reloadList()
}

protocol ForecastPresenter {
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func cellIdentifier(at indexPath: IndexPath) -> String
    func titleForHeader(in section: Int) -> String
    func configure(cell: ConfigurableCell, at indexPath: IndexPath)
    func viewDidLoad()
}

class ForecastPresenterImpl: ForecastPresenter {
    
    private weak var view: ForecastView?
    private var router: ForecastRouter
    
    private let forecastUseCase: ForecastUseCase
        
    private var tableDataSource: [SectionModel] = []
    
    init(view: ForecastView, router: ForecastRouter, forecastUseCase: ForecastUseCase) {
        self.view = view
        self.router = router
        self.forecastUseCase = forecastUseCase
    }
    
    func viewDidLoad() {
        forecastUseCase.getForecast(for: 41.715137, and: 44.827095) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let forecast):
                    self.buildDataSource(with: forecast)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func buildDataSource(with result: ForecastResult) {
        let sections: [String: [ForecastCellModel]] = result.list.reduce(into: [:]) { (result, forecast) in
            let forecastDate = getDate(from: forecast.dt_txt)
            let hourString = getHourComponent(from: forecastDate)
            let dateString = getDateString(from: forecastDate)
            
            let newCell = ForecastCellModel(
                iconId: forecast.weather[0].icon,
                date: hourString,
                weatherDescription: forecast.weather[0].description?.capitalized ?? "N/A",
                degree: Int(forecast.main.temp).description
            )
            result[dateString, default: []].append(newCell)
        }
        
        tableDataSource = sections.sorted(by: { $0.0 < $1.0 })
                                  .map { SectionModel(title: convert(dateString: $0.key, with: "yyyy-MM-dd", to: "EEEE"), cells: $0.value) }
        view?.reloadList()
    }
    
    var numberOfSections: Int {
        return tableDataSource.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return tableDataSource[section].cells.count
    }
    
    func cellIdentifier(at indexPath: IndexPath) -> String {
        return tableDataSource[indexPath.section].cells[indexPath.row].cellIdentifier
    }
    
    func titleForHeader(in section: Int) -> String {
        return tableDataSource[section].title
    }
    
    func configure(cell: ConfigurableCell, at indexPath: IndexPath) {
        let model = tableDataSource[indexPath.section].cells[indexPath.row]
        cell.configure(with: model)
    }
}

// MARK: Date Conversion Helper Methods
extension ForecastPresenterImpl {
    
    private func getDate(from dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString)!
    }
    
    private func getHourComponent(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    private func getDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private func convert(dateString: String, with format: String, to newFormat: String) -> String {
        let oldDateFormatter = DateFormatter()
        oldDateFormatter.dateFormat = format
        let date = oldDateFormatter.date(from: dateString)!
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = newFormat
        return newDateFormatter.string(from: date)
    }
    
}
