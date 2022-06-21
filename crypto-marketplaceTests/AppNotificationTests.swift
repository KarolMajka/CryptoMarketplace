//
//  AppNotificationTests.swift
//  crypto-marketplaceTests
//
//  Created by Karol Majka on 19/06/2022.
//

import XCTest
import SwiftyMocky

@testable import crypto_marketplace

final class AppNotificationTests: XCTestCase {

    private var notificationDispatcher: AppNotificationDispatcher!
    private let observer = AppNotificationObserverMock()

    override func setUp() {
        notificationDispatcher = .init()
    }

    override func tearDown() {
        notificationDispatcher.unregisterObserver(observer)
        observer.resetMock()
        super.tearDown()
    }

    func testNotificationReceived() {
        Verify(observer, 0, .appNotificationReceived(.any))
        notificationDispatcher.registerObserver(observer)
        Verify(observer, 0, .appNotificationReceived(.any))

        notificationDispatcher.dispatch(.sceneDidBecomeActive)
        Verify(observer, 1, .appNotificationReceived(.any))
        Verify(observer, 1, .appNotificationReceived(.value(.sceneDidBecomeActive)))
    }

    func testNotificationNotRegistered() {
        Verify(observer, 0, .appNotificationReceived(.any))
        notificationDispatcher.dispatch(.sceneDidBecomeActive)
        Verify(observer, 0, .appNotificationReceived(.any))
    }

    func testUnregisterFromNotifications() {
        notificationDispatcher.registerObserver(observer)

        notificationDispatcher.dispatch(.sceneDidBecomeActive)
        Verify(observer, 1, .appNotificationReceived(.any))
        Verify(observer, 1, .appNotificationReceived(.value(.sceneDidBecomeActive)))

        notificationDispatcher.unregisterObserver(observer)
        notificationDispatcher.dispatch(.sceneDidBecomeActive)
        Verify(observer, 1, .appNotificationReceived(.any))
    }

    func testTwoObservers() {
        let observer2 = AppNotificationObserverMock()
        notificationDispatcher.registerObserver(observer)
        notificationDispatcher.registerObserver(observer2)

        notificationDispatcher.dispatch(.sceneDidBecomeActive)
        Verify(observer, 1, .appNotificationReceived(.any))
        Verify(observer, 1, .appNotificationReceived(.value(.sceneDidBecomeActive)))
        Verify(observer2, 1, .appNotificationReceived(.any))
        Verify(observer2, 1, .appNotificationReceived(.value(.sceneDidBecomeActive)))

        notificationDispatcher.unregisterObserver(observer2)
        notificationDispatcher.dispatch(.sceneDidBecomeActive)
        Verify(observer, 2, .appNotificationReceived(.any))
        Verify(observer, 2, .appNotificationReceived(.value(.sceneDidBecomeActive)))
        Verify(observer2, 1, .appNotificationReceived(.any))
        Verify(observer2, 1, .appNotificationReceived(.value(.sceneDidBecomeActive)))
    }
}
