//
//  AppNotificationObserver.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation

// sourcery: AutoMockable
protocol AppNotificationObserver: AnyObject {
    func appNotificationReceived(_ notification: AppNotification)
}
