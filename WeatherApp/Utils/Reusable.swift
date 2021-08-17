//
//  Reusable.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: Reusable {
    
}
