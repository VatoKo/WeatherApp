//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var degreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}

extension ForecastCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        if let model = model as? ForecastCellModel {
            dateLabel.text = model.date
            weatherDescriptionLabel.text = model.weatherDescription
            degreeLabel.text = "\(model.degree)°"
            if let iconId = model.iconId {
                WeatherIconUseCaseImpl(gateway: ApiWeatherIconGateway()).getIcon(with: iconId) { [weak self] (result) in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let imageData):
                            self.iconImage.image = UIImage(data: imageData)
                        case .failure: break
                        }
                    }
                }
            }
        }
    }
    
}
