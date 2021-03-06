//
//  UIColor.extension.swift
//  Emery
//
//  Created by Daniel Eden on 06/03/2021.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(from256red red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat(red) / 256.0,
            green: CGFloat(green) / 256.0,
            blue: CGFloat(blue) / 256.0,
            alpha: alpha
        )
    }
}
