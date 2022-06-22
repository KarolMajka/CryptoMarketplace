//
//  BitfinexError.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 18/06/2022.
//

import Moya

enum BitfinexError {
    case server(error: BitfinexErrorResponse)
    case symbolNotRecognized(symbol: String)
}

extension BitfinexError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .server(let error):
            return error.message
        case .symbolNotRecognized(let symbol):
            return L10n.BitfinexError.symbolNotRecognized(symbol)
        }
    }
}
