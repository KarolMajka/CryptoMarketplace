//
//  BitfinexTicker.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 18/06/2022.
//

import Foundation

struct BitfinexTicker: Decodable {

    let symbol: String
    let coins: BitfinexCoinPair
    let ffr: Double?
    let bid: Double
    let bidPeriod: Double?
    let bidSize: Double
    let ask: Double
    let askPeriod: Double?
    let askSize: Double
    let dailyChange: Double
    let dailyChangeRelative: Double
    let lastPrice: Double
    let volume: Double
    let high: Double
    let low: Double
    let frrAmountAvailable: Double?

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        symbol = try container.decode(String.self)
        coins = try BitfinexCoinType.build(fromSymbol: symbol)
        let isFundingPair = symbol.first == Character(Constants.API.Bitfinex.fundingPairPrefix)
        ffr = isFundingPair ? try container.decode(Double.self) : nil
        bid = try container.decode(Double.self)
        bidPeriod = isFundingPair ? try container.decode(Double.self) : nil
        bidSize = try container.decode(Double.self)
        ask = try container.decode(Double.self)
        askPeriod = isFundingPair ? try container.decode(Double.self) : nil
        askSize = try container.decode(Double.self)
        dailyChange = try container.decode(Double.self)
        dailyChangeRelative = try container.decode(Double.self)
        lastPrice = try container.decode(Double.self)
        volume = try container.decode(Double.self)
        high = try container.decode(Double.self)
        low = try container.decode(Double.self)
        _ = isFundingPair ? try container.decodeNil() : nil
        _ = isFundingPair ? try container.decodeNil() : nil
        frrAmountAvailable = isFundingPair ? try container.decode(Double.self) : nil
    }
}
