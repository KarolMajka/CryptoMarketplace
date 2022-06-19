//
//  Observable+FilterNill.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    /// Cast `Optional<Wrapped>` to `Wrapped?`
    var value: Wrapped? {
        self
    }
}

extension ObservableType where Element: OptionalType {
    func filterNil() -> Observable<Element.Wrapped> {
        flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.value else {
                return .empty()
            }
            return .just(value)
        }
    }
}

extension Driver where Element: OptionalType {
    func filterNil() -> Driver<Element.Wrapped> {
        flatMap { element -> Driver<Element.Wrapped> in
            guard let value = element.value else {
                return .empty()
            }
            return .just(value)
        }
    }
}
