//
//  CryptoMarketplaceSearchFilterContains.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation

final class CryptoMarketplaceSearchFilterContains: CryptoMarketplaceSearchFilter {
    func filter(model: BitfinexTicker, searchText: String?) -> Bool {
        guard let searchText = searchText?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
                !searchText.isEmpty
        else {
            return true
        }
        return model.coins.leftCoin.rawValue.contains(searchText) ||
            searchText.contains(model.coins.leftCoin.rawValue) ||
            (model.coins.rightCoin?.rawValue ?? "").contains(searchText) ||
            searchText.contains(model.coins.rightCoin?.rawValue ?? "")
    }
}
