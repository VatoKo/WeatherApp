//
//  TitleHeaderView.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 18.08.21.
//

import UIKit

class TitleHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var titleLabel: UILabel!

}

extension TitleHeaderView: ConfigurableCell {
    
    func configure(with model: CellModel) {
        if let model = model as? TitleHeaderViewModel {
            titleLabel.text = model.title
        }
    }
    
}
