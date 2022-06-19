//
//  JSONDecoder+Default.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 18/06/2022.
//

import Foundation

extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()
}
