//
//  CryptoMarketplaceCellViewModelTests.swift
//  crypto-marketplaceTests
//
//  Created by Karol Majka on 21/06/2022.
//

import XCTest

@testable import crypto_marketplace

final class CryptoMarketplaceCellViewModelTests: XCTestCase {

    private var sut: CryptoMarketplaceCellViewModel!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLeftCoinText() {
        let coins: BitfinexCoinPair = (.btc, .usd)

        let model = buildModel(coins: coins)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.leftCoinText, coins.leftCoin.ticker)
    }

    func testRightCoinText() throws {
        let coins: BitfinexCoinPair = (.btc, .usd)

        let model = buildModel(coins: coins)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.rightCoinText, "/\(try XCTUnwrap(coins.rightCoin).ticker)")
    }

    func testRightCoinTextEmpty() {
        let coins: BitfinexCoinPair = (.btc, nil)

        let model = buildModel(coins: coins)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.rightCoinText, "/")
    }

    func testLastPriceText() {
        let lastPrice: Double = 0

        let model = buildModel(lastPrice: lastPrice)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.lastPriceText, lastPrice.formatted(.number))
    }

    func testLastPriceTextFormatting() {
        let lastPrice: Double = 10_000

        let model = buildModel(lastPrice: lastPrice)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.lastPriceText, lastPrice.formatted(.number))
    }


    func testPreviousTickerNotChanged() {
        let lastPrice: Double = 0
        let previousLastPrice: Double = 0

        let model = buildModel(lastPrice: lastPrice)
        let previousModel = buildModel(lastPrice: previousLastPrice)
        sut = .init(ticker: model, previousTicker: previousModel)

        XCTAssertEqual(sut.output.cell.lastPriceColor, .unchanged)
    }

    func testPreviousTickerUp() {
        let lastPrice: Double = 1
        let previousLastPrice: Double = 0

        let model = buildModel(lastPrice: lastPrice)
        let previousModel = buildModel(lastPrice: previousLastPrice)
        sut = .init(ticker: model, previousTicker: previousModel)

        XCTAssertEqual(sut.output.cell.lastPriceColor, .up)
    }

    func testPreviousTickerDown() {
        let lastPrice: Double = 0
        let previousLastPrice: Double = 1

        let model = buildModel(lastPrice: lastPrice)
        let previousModel = buildModel(lastPrice: previousLastPrice)
        sut = .init(ticker: model, previousTicker: previousModel)

        XCTAssertEqual(sut.output.cell.lastPriceColor, .down)
    }

    func testPriceChangeTextZero() {
        let dailyChangeRelative: Double = 0

        let model = buildModel(dailyChangeRelative: dailyChangeRelative)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.priceChangeText, dailyChangeRelative.formatted(.percent.sign(strategy: .always()).precision(.fractionLength(2))))
    }

    func testPriceChangeTextPositive() {
        let dailyChangeRelative: Double = 10.5

        let model = buildModel(dailyChangeRelative: dailyChangeRelative)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.priceChangeText, dailyChangeRelative.formatted(.percent.sign(strategy: .always()).precision(.fractionLength(2))))
    }

    func testPriceChangeTextNegative() {
        let dailyChangeRelative: Double = -10.21

        let model = buildModel(dailyChangeRelative: dailyChangeRelative)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.priceChangeText, dailyChangeRelative.formatted(.percent.sign(strategy: .always()).precision(.fractionLength(2))))
    }

    func testPriceChangeColorUnchanged() {
        let dailyChangeRelative: Double = 0

        let model = buildModel(dailyChangeRelative: dailyChangeRelative)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.priceChangeColor, .unchanged)
    }

    func testPriceChangeColorUp() {
        let dailyChangeRelative: Double = 1

        let model = buildModel(dailyChangeRelative: dailyChangeRelative)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.priceChangeColor, .up)
    }

    func testPriceChangeColorDown() {
        let dailyChangeRelative: Double = -1

        let model = buildModel(dailyChangeRelative: dailyChangeRelative)
        sut = .init(ticker: model)

        XCTAssertEqual(sut.output.cell.priceChangeColor, .down)
    }

    private func buildModel(coins: BitfinexCoinPair = (.btc, .usd), dailyChangeRelative: Double = 0, lastPrice: Double = 0) -> BitfinexTicker {
        .init(
            symbol: "",
            coins: coins,
            ffr: nil,
            bid: 0,
            bidPeriod: nil,
            bidSize: 0,
            ask: 0,
            askPeriod: nil,
            askSize: 0,
            dailyChange: 0,
            dailyChangeRelative: dailyChangeRelative,
            lastPrice: lastPrice,
            volume: 0,
            high: 0,
            low: 0,
            frrAmountAvailable: nil
        )
    }
}
