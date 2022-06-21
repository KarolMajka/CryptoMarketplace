//
//  CryptoMarketplaceSearchFilter.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation

// sourcery: AutoMockable
protocol CryptoMarketplaceSearchFilter {
    func filter(model: BitfinexTicker, searchText: String?) -> Bool
}
