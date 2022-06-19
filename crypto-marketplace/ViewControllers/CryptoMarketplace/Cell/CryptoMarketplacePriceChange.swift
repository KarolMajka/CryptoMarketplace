//
//  CryptoMarketplacePriceChange.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import UIKit.UIColor

enum CryptoMarketplacePriceChange {
    case up
    case down
    case unchanged

    var backgroundColor: UIColor {
        switch self {
        case .up:
            return .init(red: 95/255, green: 186/255, blue: 137/255, alpha: 1)
        case .down:
            return .init(red: 227/255, green: 84/255, blue: 97/255, alpha: 1)
        case .unchanged:
            return .init(red: 134/255, green: 141/255, blue: 154/255, alpha: 1)
        }
    }

    var textColor: UIColor {
        switch self {
        case .up:
            return .init(red: 95/255, green: 186/255, blue: 137/255, alpha: 1)
        case .down:
            return .init(red: 227/255, green: 84/255, blue: 97/255, alpha: 1)
        case .unchanged:
            return .init(light: .black, dark: .white)
        }
    }

    init(priceChange: Double) {
        if priceChange == 0 {
            self = .unchanged
        } else if priceChange > 0 {
            self = .up
        } else {
            self = .down
        }
    }
}
