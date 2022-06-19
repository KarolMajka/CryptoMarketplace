//
//  CryptoMarketplaceSearchFilterContainsTests.swift
//  crypto-marketplaceTests
//
//  Created by Karol Majka on 19/06/2022.
//

import XCTest

@testable import crypto_marketplace

final class CryptoMarketplaceSearchFilterContainsTests: XCTestCase {

    let sut = CryptoMarketplaceSearchFilterContains()

    func testEmptySearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = ""

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testNilSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText: String? = nil

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testUppercasedBtcSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "BTC"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testLowercasedBtcSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "btc"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testUsdSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "USD"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testBSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "B"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testCSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "C"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testUSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "U"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testDSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "D"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testBtcUsdSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "BTCUSD"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testUsdBtcSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "USDBTC"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testBtcUsdWithSlashSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "BTC/USD"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testUsdBtcWithSlashSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "USD/BTC"

        XCTAssertTrue(sut.filter(model: model, searchText: searchText))
    }

    func testEthSearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "ETH"

        XCTAssertFalse(sut.filter(model: model, searchText: searchText))
    }

    func testESearch() {
        let model = buildModel(coins: (.btc, .usd))
        let searchText = "E"

        XCTAssertFalse(sut.filter(model: model, searchText: searchText))
    }

    private func buildModel(coins: BitfinexCoinPair) -> BitfinexTicker {
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
            dailyChangeRelative: 0,
            lastPrice: 0,
            volume: 0,
            high: 0,
            low: 0,
            frrAmountAvailable: nil
        )
    }
}
