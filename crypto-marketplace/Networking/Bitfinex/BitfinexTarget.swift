//
//  BitfinexTarget.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 17/06/2022.
//

import Moya

enum BitfinexTarget {
    case tickers(params: BitfinexTickersParams)
}

extension BitfinexTarget: TargetType {
    static let provider = MoyaProvider<Self>()

    var baseURL: URL {
        Constants.API.Bitfinex.baseUrl
    }

    var path: String {
        "tickers"
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case .tickers(let params):
            return .requestParameters(parameters: params.dictionary, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        nil
    }
}
