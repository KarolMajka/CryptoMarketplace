//
//  ActivityIndicator.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import RxSwift
import RxCocoa

private struct ActivityToken<E>: ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable

    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }

    func dispose() {
        _dispose.dispose()
    }

    func asObservable() -> Observable<E> {
        _source
    }
}

private struct ActivityTokenPrimitive<Trait, Element>: PrimitiveSequenceType, Disposable {
    var primitiveSequence: PrimitiveSequence<Trait, Element>

    private let _dispose: Cancelable

    init(source: PrimitiveSequence<Trait, Element>, disposeAction: @escaping () -> Void) {
        _dispose = Disposables.create(with: disposeAction)
        primitiveSequence = source
    }

    func dispose() {
        _dispose.dispose()
    }
}

/**
Enables monitoring of sequence computation.
If there is at least one sequence computation in progress, `true` will be sent.
When all activities complete `false` will be sent.
*/
public class ActivityIndicator: SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay(value: 0)
    private let _loading: SharedSequence<SharingStrategy, Bool>

    public init() {
        _loading = _relay.asDriver()
            .map { $0 > 0 }
            .distinctUntilChanged()
    }

    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }, observableFactory: { t in
            return t.asObservable()
        })
    }

    fileprivate func trackActivityOfPrimitive<O: PrimitiveSequenceType>(_ source: O) -> PrimitiveSequence<O.Trait, O.Element> {
        return PrimitiveSequence.using({ () -> ActivityTokenPrimitive<O.Trait, O.Element> in
            self.increment()
            return ActivityTokenPrimitive(source: source.primitiveSequence, disposeAction: self.decrement)
        }, primitiveSequenceFactory: { (token: ActivityTokenPrimitive<O.Trait, O.Element>) -> PrimitiveSequence<O.Trait, O.Element> in
            return token.primitiveSequence
        })
    }

    private func increment() {
        _lock.lock()
        _relay.accept(_relay.value + 1)
        _lock.unlock()
    }

    private func decrement() {
        _lock.lock()
        _relay.accept(_relay.value - 1)
        _lock.unlock()
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        _loading
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator?) -> Observable<Element> {
        activityIndicator?.trackActivityOfObservable(self) ?? asObservable()
    }
}

extension PrimitiveSequenceType {
    func trackActivity(_ activityIndicator: ActivityIndicator?) -> PrimitiveSequence<Trait, Element> {
        activityIndicator?.trackActivityOfPrimitive(self) ?? primitiveSequence
    }
}
