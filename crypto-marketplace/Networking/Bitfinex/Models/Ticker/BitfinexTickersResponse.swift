//
//  BitfinexTickersResponse.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 18/06/2022.
//

import Foundation

struct BitfinexTickersResponse: Decodable {
    let tickers: [BitfinexTicker]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        tickers = try container.decode([BitfinexTicker].self)
    }
}
