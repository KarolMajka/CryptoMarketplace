//
//  CryptoMarketplaceTimerContractor.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 21/06/2022.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol CryptoMarketplaceTimerContractor {
    var fired: Observable<Void> { get }
    func start()
    func stop()
}
