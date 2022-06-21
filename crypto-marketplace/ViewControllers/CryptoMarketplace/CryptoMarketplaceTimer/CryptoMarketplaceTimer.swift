//
//  CryptoMarketplaceTimer.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 21/06/2022.
//

import Foundation
import RxSwift

final class CryptoMarketplaceTimer: CryptoMarketplaceTimerContractor {

    var fired: Observable<Void> {
        firedSubject.asObserver()
    }

    private weak var timer: Timer?

    private let firedSubject = PublishSubject<Void>()
    private let refreshTimeIntervalInSeconds: TimeInterval

    init(refreshTimeIntervalInSeconds: TimeInterval = Constants.CryptoMarketplace.refreshTimeIntervalInSeconds) {
        self.refreshTimeIntervalInSeconds = refreshTimeIntervalInSeconds
    }

    deinit {
        stop()
    }

    func start() {
        timer?.invalidate()
        guard UIApplication.shared.applicationState == .active || UIApplication.shared.applicationState == .inactive else { return }

        let timer = Timer.scheduledTimer(withTimeInterval: refreshTimeIntervalInSeconds, repeats: false, block: { [weak self] timer in
            self?.firedSubject.onNext(())
        })
        self.timer = timer

        RunLoop.main.add(timer, forMode: .common)
    }

    func stop() {
        timer?.invalidate()
    }
}
