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
            return .red
        case .down:
            return .green
        case .unchanged:
            return .grayBackground
        }
    }

    var textColor: UIColor {
        switch self {
        case .up:
            return .green
        case .down:
            return .red
        case .unchanged:
            return .primaryText
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
