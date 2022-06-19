//
//  UIColor+AppearanceMode.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import UIKit

extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init { trait in
            switch trait.userInterfaceStyle {
            case .unspecified, .light:
                return light
            case .dark:
                return dark
            @unknown default:
                return light
            }
        }
    }
}
