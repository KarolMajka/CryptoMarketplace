//
//  Collection+SafeAccess.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 18/06/2022.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        index >= startIndex && index < endIndex ? self[index] : nil
    }
}
