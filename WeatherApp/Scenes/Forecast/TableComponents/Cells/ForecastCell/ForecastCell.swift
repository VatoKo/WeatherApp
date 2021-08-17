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
            DispatchQueue.global().async {
                if let iconId = model.iconId,
                   let url = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png"),
                   let imageData = try? Data(contentsOf: url)
                {
                    DispatchQueue.main.async {
                        self.iconImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
}
