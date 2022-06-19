//
//  BitfinexCoinType.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 17/06/2022.
//

import Foundation

enum BitfinexCoinType: String {
    case btc
    case eth
    case chsb
    case ltc
    case xrp
    case dsh
    case rrt
    case eos
    case san
    case dat
    case snt
    case doge
    case luna
    case matic
    case nexo
    case ocean
    case best
    case aave
    case plu
    case fil
    case usdt
    case busd
    case usd

    var ticker: String {
        rawValue.uppercased()
    }

    static func build(fromSymbol symbol: String) throws -> BitfinexCoinPair {
        let symbolWithoutTicker = String(symbol.dropFirst())
        let tickerType = symbol.first

        if tickerType == Character(Constants.API.Bitfinex.fundingPairPrefix) {
            guard let coin = BitfinexCoinType(rawValue: symbolWithoutTicker.lowercased()) else { throw BitfinexError.symbolNotRecognized(symbol: symbol) }
            return (coin, nil)
        }
        let tickers = symbolWithoutTicker.split(separator: Character(Constants.API.Bitfinex.tickerSeparator))
        if tickers.count == 2 {
            guard let leftCoin = BitfinexCoinType(rawValue: tickers[0].lowercased()),
                  let rightCoin = BitfinexCoinType(rawValue: tickers[1].lowercased())
            else {
                throw BitfinexError.symbolNotRecognized(symbol: symbol)
            }
            return (leftCoin, rightCoin)
        }
        if symbolWithoutTicker.count == (Constants.API.Bitfinex.minimumTickerLengthForSeparator - 1) * 2 {
            let startFirstTicker = symbolWithoutTicker.startIndex
            let endFirstTicker = symbolWithoutTicker.index(startFirstTicker, offsetBy: Constants.API.Bitfinex.minimumTickerLengthForSeparator - 1)
            let startSecondTicker = endFirstTicker
            let endSecondTicker = symbolWithoutTicker.index(startSecondTicker, offsetBy: Constants.API.Bitfinex.minimumTickerLengthForSeparator - 1)

            guard let leftCoin = BitfinexCoinType(rawValue: symbolWithoutTicker[startFirstTicker..<endFirstTicker].lowercased()),
                  let rightCoin = BitfinexCoinType(rawValue: symbolWithoutTicker[startSecondTicker..<endSecondTicker].lowercased())
            else {
                throw BitfinexError.symbolNotRecognized(symbol: symbol)
            }
            return (leftCoin, rightCoin)
        }
        throw BitfinexError.symbolNotRecognized(symbol: symbol)
    }
}
