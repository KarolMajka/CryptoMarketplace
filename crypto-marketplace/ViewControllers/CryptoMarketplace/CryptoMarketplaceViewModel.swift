//
//  CryptoMarketplaceViewModel.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class CryptoMarketplaceViewModel {

    let input = Input()
    let output = Output()

    private let disposeBag = DisposeBag()

    private let products: BehaviorRelay<[BitfinexTicker]> = .init(value: [])

    struct Dependencies {
        let service: BitfinexService
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies = .init(service: .init())) {
        self.dependencies = dependencies
        setupRxObservers()
    }
}

// MARK: - RxObservers
private extension CryptoMarketplaceViewModel {
    func setupRxObservers() {
        setupViewInputs()

        products
            .map { $0.map { CryptoMarketplaceCellViewModel(ticker: $0) } }
            .bind(to: output.view.cellViewModelsSubject)
            .disposed(by: disposeBag)
    }

    func setupViewInputs() {
        input.view.fetchData
            .asObservable()
            .subscribe(with: self, onNext: { (self, _) in
                self.fetchCrypto()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Networking
private extension CryptoMarketplaceViewModel {
    func fetchCrypto() {
        let coinPairs = CryptoMarketplaceCoinPairsBuilder().buildSupportedCoinPairs()
        let params: BitfinexTickersParams = .init(symbols: .init(coinPairs: coinPairs))
        dependencies.service.getTickers(params: params)
            .trackActivity(self.products.value.isEmpty ? output.view.activityIndicator : nil)
            .subscribe(with: self, onSuccess: { (self, response) in
                self.products.accept(response.tickers)
            }, onFailure: { (self, error) in
                if self.products.value.isEmpty {
                    self.output.view.errorAlertSubject.accept(error.localizedDescription)
                } else {
                    self.output.view.errorMessageSubject.accept(error.localizedDescription)
                }
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Input
extension CryptoMarketplaceViewModel {
    struct Input {
        let view: View = View()

        struct View {
            let fetchData = PublishSubject<Void>()
        }
    }
}

// MARK: - Output
extension CryptoMarketplaceViewModel {
    struct Output {
        let view: View = View()

        struct View {
            let activityIndicator = ActivityIndicator()
            var cellViewModels: Driver<[CellViewModel]> { cellViewModelsSubject.asDriver(onErrorJustReturn: []) }
            var errorMessage: Driver<String?> { errorMessageSubject.asDriver(onErrorJustReturn: nil) }
            var errorAlert: Driver<String?> { errorAlertSubject.asDriver(onErrorJustReturn: nil) }

            fileprivate let cellViewModelsSubject = BehaviorRelay<[CellViewModel]>(value: [])
            fileprivate let errorMessageSubject = BehaviorRelay<String?>(value: nil)
            fileprivate let errorAlertSubject = BehaviorRelay<String?>(value: nil)

        }
    }
}
