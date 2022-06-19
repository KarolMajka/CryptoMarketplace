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
    typealias ModelWithCell = (model: BitfinexTicker, cellViewModel: CryptoMarketplaceCellViewModel)

    let input = Input()
    let output = Output()

    private let disposeBag = DisposeBag()

    private let models: BehaviorRelay<[BitfinexTicker]> = .init(value: [])
    private let cells: BehaviorRelay<[ModelWithCell]> = .init(value: [])

    struct Dependencies {
        let service: BitfinexService
        let searchFilter: CryptoMarketplaceSearchFilter
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies = .init(service: .init(), searchFilter: CryptoMarketplaceSearchFilterContains())) {
        self.dependencies = dependencies
        setupRxObservers()
    }
}

// MARK: - RxObservers
private extension CryptoMarketplaceViewModel {
    func setupRxObservers() {
        setupViewInputs()

        models
            .map { $0.map { ($0, CryptoMarketplaceCellViewModel(ticker: $0)) } }
            .bind(to: cells)
            .disposed(by: disposeBag)
    }

    func setupViewInputs() {
        input.view.fetchData
            .asObservable()
            .subscribe(with: self, onNext: { (self, _) in
                self.fetchCrypto()
            })
            .disposed(by: disposeBag)

        Observable.combineLatest(cells, input.view.searchText.distinctUntilChanged())
            .map { [weak self] cells, searchText in
                cells
                    .filter { [weak self] in
                        self?.dependencies.searchFilter.filter(model: $0.model, searchText: searchText) ?? true
                    }
                    .map { $0.cellViewModel }
            }
            .bind(to: output.view.cellViewModelsSubject)
            .disposed(by: disposeBag)
    }
}

// MARK: - Networking
private extension CryptoMarketplaceViewModel {
    func fetchCrypto() {
        let coinPairs = CryptoMarketplaceCoinPairsBuilder().buildSupportedCoinPairs()
        let params: BitfinexTickersParams = .init(symbols: .init(coinPairs: coinPairs))
        dependencies.service.getTickers(params: params)
            .trackActivity(self.models.value.isEmpty ? output.view.activityIndicator : nil)
            .subscribe(with: self, onSuccess: { (self, response) in
                self.models.accept(response.tickers)
            }, onFailure: { (self, error) in
                if self.models.value.isEmpty {
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
            let searchText = PublishSubject<String?>()
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
