//
//  Constants.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 17/06/2022.
//

import Foundation

enum Constants { }

// MARK: - API
extension Constants {
    enum API { }
}

// MARK: - API.Bitfinex
extension Constants.API {
    enum Bitfinex {
        static let baseUrl = URL(string: "https://api-pub.bitfinex.com/v2/")!

        static let tradingPairPrefix = "t"
        static let fundingPairPrefix = "f"
        static let tickerSeparator = ":"
        static let minimumTickerLengthForSeparator = 4
        static let pairsSeparator = ","
    }
}
