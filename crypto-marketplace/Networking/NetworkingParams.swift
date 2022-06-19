//
//  NetworkingParams.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 17/06/2022.
//

import Foundation

protocol NetworkingParams {
    var dictionary: [String: Any] { get }
}

extension NetworkingParams {
    var dictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)

        let sequence = mirror
            .children
            .lazy
            .map { (label: String?, value: Any) -> (String, Any)? in
                guard let label = label else { return nil }
                if let param = value as? NetworkingParam {
                    return (label, param.value)
                }
                return (label, value)
            }
            .compactMap { $0 }

        let dict = Dictionary(uniqueKeysWithValues: sequence)
        return dict
    }
}
