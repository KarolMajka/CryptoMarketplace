//
//  CryptoMarketplaceCellViewModel.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation

final class CryptoMarketplaceCellViewModel: CellViewModel {
    let output: Output

    init(ticker: BitfinexTicker, previousTicker: BitfinexTicker? = nil) {
        var lastPriceChange: CryptoMarketplacePriceChange = .unchanged
        if let previousTicker = previousTicker {
            lastPriceChange = .init(priceChange: ticker.lastPrice - previousTicker.lastPrice)
        }

        output = .init(cell: .init(
            leftCoinText: ticker.coins.leftCoin.ticker,
            rightCoinText: L10n.CryptoMarketplace.Cell.rightCoinText(ticker.coins.rightCoin?.ticker ?? ""),
            lastPriceText: ticker.lastPrice.formatted(.number),
            lastPriceColor: lastPriceChange,
            priceChangeText: ticker.dailyChangeRelative.formatted(.percent.sign(strategy: .always()).precision(.fractionLength(2))),
            priceChangeColor: .init(priceChange: ticker.dailyChangeRelative)
        ))
    }
}

// MARK: - Output
extension CryptoMarketplaceCellViewModel {
    struct Output {
        let cell: Cell

        struct Cell {
            let leftCoinText: String
            let rightCoinText: String
            let lastPriceText: String
            let lastPriceColor: CryptoMarketplacePriceChange
            let priceChangeText: String
            let priceChangeColor: CryptoMarketplacePriceChange
        }
    }
}
