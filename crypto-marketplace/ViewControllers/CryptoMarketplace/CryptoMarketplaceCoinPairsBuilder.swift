//
//  CryptoMarketplaceCoinPairsBuilder.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation

final class CryptoMarketplaceCoinPairsBuilder {
    func buildSupportedCoinPairs() -> [BitfinexCoinPair] {
        [
            (.btc, .usd),
            (.eth, .usd),
            (.chsb, .usd),
            (.ltc, .usd),
            (.xrp, .usd),
            (.dsh, .usd),
            (.rrt, .usd),
            (.eos, .usd),
            (.san, .usd),
            (.dat, .usd),
            (.snt, .usd),
            (.doge, .usd),
            (.luna, .usd),
            (.matic, .usd),
            (.nexo, .usd),
            (.ocean, .usd),
            (.best, .usd),
            (.aave, .usd),
            (.plu, .usd),
            (.fil, .usd),
        ]
    }
}
