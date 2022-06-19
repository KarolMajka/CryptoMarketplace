//
//  Response+ErrorHandling.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 18/06/2022.
//

import Moya
import RxSwift

extension PrimitiveSequenceType where Element == Response, Trait == SingleTrait {
    func checkAndParseErrorIfExists() -> Single<Response> {
        return flatMap { response in
            guard response.statusCode != 400 else {
                let error = try response.map(BitfinexErrorResponse.self, using: .default)
                return .error(BitfinexError.server(error: error))
            }
            return .just(try response.filterSuccessfulStatusCodes())
        }
    }
}
