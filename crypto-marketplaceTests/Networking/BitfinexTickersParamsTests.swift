//
//  BitfinexTickersParamsTests.swift
//  crypto-marketplaceTests
//
//  Created by Karol Majka on 19/06/2022.
//

import XCTest

@testable import crypto_marketplace

final class BitfinexTickersParamsTests: XCTestCase {

    func testTickersParamsBuildBtcUsd() {
        let params = BitfinexTickersParams(symbols: .init(coinPairs: [
            (.btc, .usd),
        ]))
        let dict = params.dictionary

        XCTAssertEqual(dict.count, 1)
        XCTAssertNotNil(dict["symbols"] as? String)
        XCTAssertEqual(dict["symbols"] as? String, "tBTCUSD")
    }

    func testTickersParamsBuildLunaUsd() {
        let params = BitfinexTickersParams(symbols: .init(coinPairs: [
            (.luna, .usd),
        ]))
        let dict = params.dictionary

        XCTAssertEqual(dict.count, 1)
        XCTAssertNotNil(dict["symbols"] as? String)
        XCTAssertEqual(dict["symbols"] as? String, "tLUNA:USD")
    }

    func testTickersParamsBuildEthBtc() {
        let params = BitfinexTickersParams(symbols: .init(coinPairs: [
            (.eth, .btc),
        ]))
        let dict = params.dictionary

        XCTAssertEqual(dict.count, 1)
        XCTAssertNotNil(dict["symbols"] as? String)
        XCTAssertEqual(dict["symbols"] as? String, "tETHBTC")
    }

    func testTickersParamsBuildOceanNexo() {
        let params = BitfinexTickersParams(symbols: .init(coinPairs: [
            (.ocean, .nexo),
        ]))
        let dict = params.dictionary

        XCTAssertEqual(dict.count, 1)
        XCTAssertNotNil(dict["symbols"] as? String)
        XCTAssertEqual(dict["symbols"] as? String, "tOCEAN:NEXO")
    }

    func testTickersParamsBuildBtcBest() {
        let params = BitfinexTickersParams(symbols: .init(coinPairs: [
            (.btc, .best),
        ]))
        let dict = params.dictionary

        XCTAssertEqual(dict.count, 1)
        XCTAssertNotNil(dict["symbols"] as? String)
        XCTAssertEqual(dict["symbols"] as? String, "tBTC:BEST")
    }

    func testTickersParamsBuildFunding() {
        let params = BitfinexTickersParams(symbols: .init(coinPairs: [
            (.btc, nil),
        ]))
        let dict = params.dictionary

        XCTAssertEqual(dict.count, 1)
        XCTAssertNotNil(dict["symbols"] as? String)
        XCTAssertEqual(dict["symbols"] as? String, "fBTC")
    }

    func testTickersParamsBuildMultipleSymbols() {
        let params = BitfinexTickersParams(symbols: .init(coinPairs: [
            (.btc, .usd),
            (.luna, .usd),
        ]))
        let dict = params.dictionary

        XCTAssertEqual(dict.count, 1)
        XCTAssertNotNil(dict["symbols"] as? String)
        XCTAssertEqual(dict["symbols"] as? String, "tBTCUSD,tLUNA:USD")
    }
}
