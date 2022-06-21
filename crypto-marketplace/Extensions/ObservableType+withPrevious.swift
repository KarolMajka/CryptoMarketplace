//
//  ObservableType+withPrevious.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 21/06/2022.
//

import RxSwift

extension ObservableType {
    func withPrevious(startWith first: Element? = nil) -> Observable<(previous: Element?, current: Element)> {
        scan((first, first)) { ($0.1, $1) }
            .skip(1)
            .filter { _, current in
                current != nil
            }
            .map { ($0, $1!) }
    }
}
