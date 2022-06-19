//
//  BitfinexService.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 17/06/2022.
//

import Moya
import RxSwift

// sourcery: AutoMockable
protocol BitfinexServiceProtocol {
    func getTickers(params: BitfinexTickersParams) -> Single<BitfinexTickersResponse>
}

final class BitfinexService: BitfinexServiceProtocol {

    private let provider: MoyaProvider<BitfinexTarget>

    init(provider: MoyaProvider<BitfinexTarget> = .init()) {
        self.provider = provider
    }

    func getTickers(params: BitfinexTickersParams) -> Single<BitfinexTickersResponse> {
        provider.rx.request(.tickers(params: params))
            .checkAndParseErrorIfExists()
            .map(BitfinexTickersResponse.self, using: .default)
            .logErrorIfNeeded()
    }
}
