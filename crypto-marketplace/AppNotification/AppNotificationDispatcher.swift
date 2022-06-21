//
//  AppNotificationDispatcher.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation

private final class ObserverContainer {
    weak private(set) var observer: AppNotificationObserver?

    init(observer: AppNotificationObserver) {
        self.observer = observer
    }
}

final class AppNotificationDispatcher {

    static let shared = AppNotificationDispatcher()

    // MARK: Properties

    private var observers: [ObserverContainer] = []

    // MARK: Initialization

    init() { }

    deinit {
        observers
            .compactMap { $0.observer }
            .forEach {
                self.unregisterObserver($0)
            }
    }

    // MARK: Methods

    func dispatch(_ notification: AppNotification) {
        observers.forEach {
            $0.observer?.appNotificationReceived(notification)
        }
    }

    func registerObserver(_ observer: AppNotificationObserver) {
        unregisterObserver(observer)
        observers.append(.init(observer: observer))
    }

    func unregisterObserver(_ observer: AppNotificationObserver) {
        observers = observers.filter { $0.observer !== observer }
    }
}
