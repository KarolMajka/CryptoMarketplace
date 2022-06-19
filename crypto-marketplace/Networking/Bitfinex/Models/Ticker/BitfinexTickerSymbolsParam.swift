//
//  BitfinexTickerSymbolsParam.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 17/06/2022.
//

import Foundation

struct BitfinexTickerSymbolsParam: NetworkingParam {

    var value: String {
        return coinPairs
            .map {
                if let rightCoin = $0.rightCoin {
                    let tradingPairPrefix = Constants.API.Bitfinex.tradingPairPrefix
                    var leftCoinTicker = $0.leftCoin.ticker
                    let rightCoinTicker = rightCoin.ticker
                    if leftCoinTicker.count >= Constants.API.Bitfinex.minimumTickerLengthForSeparator ||
                        rightCoinTicker.count >= Constants.API.Bitfinex.minimumTickerLengthForSeparator {
                        leftCoinTicker += Constants.API.Bitfinex.tickerSeparator
                    }
                    return "\(tradingPairPrefix)\(leftCoinTicker)\(rightCoinTicker)"
                }
                return "\(Constants.API.Bitfinex.fundingPairPrefix)\($0.leftCoin.ticker)"

            }
            .joined(separator: Constants.API.Bitfinex.pairsSeparator)
    }

    let coinPairs: [BitfinexCoinPair]
}
