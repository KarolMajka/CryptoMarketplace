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
    private var requestDisposable: Disposable?

    private let models: BehaviorRelay<[BitfinexTicker]> = .init(value: [])
    private let cells: BehaviorRelay<[ModelWithCell]> = .init(value: [])

    struct Dependencies {
        let service: BitfinexServiceProtocol
        let searchFilter: CryptoMarketplaceSearchFilter
        let timer: CryptoMarketplaceTimerContractor
        let notificationDispatcher: AppNotificationDispatcher

        init(
            service: BitfinexServiceProtocol = BitfinexService(),
            searchFilter: CryptoMarketplaceSearchFilter = CryptoMarketplaceSearchFilterContains(),
            timer: CryptoMarketplaceTimerContractor = CryptoMarketplaceTimer(),
            notificationDispatcher: AppNotificationDispatcher = AppNotificationDispatcher.shared
        ) {
            self.service = service
            self.searchFilter = searchFilter
            self.timer = timer
            self.notificationDispatcher = notificationDispatcher
        }
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
        setupRxObservers()
        dependencies.notificationDispatcher.registerObserver(self)
    }

    deinit {
        dependencies.notificationDispatcher.unregisterObserver(self)
        dependencies.timer.stop()
        requestDisposable?.dispose()
    }
}

// MARK: - AppNotificationObserver
extension CryptoMarketplaceViewModel: AppNotificationObserver {
    func appNotificationReceived(_ notification: AppNotification) {
        switch notification {
        case .sceneDidBecomeActive:
            fetchCrypto()
        case .sceneWillResignActive:
            dependencies.timer.stop()
            requestDisposable?.dispose()
        }
    }
}

// MARK: - RxObservers
private extension CryptoMarketplaceViewModel {
    func setupRxObservers() {
        setupViewObservers()

        models
            .withPrevious()
            .map { previousModels, currentModels in
                currentModels.map { model in
                    (model, CryptoMarketplaceCellViewModel(ticker: model, previousTicker: previousModels?.first(where: { $0.symbol == model.symbol })))
                }
            }
            .bind(to: cells)
            .disposed(by: disposeBag)

        dependencies.timer.fired
            .subscribe(with: self, onNext: { (self, _) in
                self.fetchCrypto()
            })
            .disposed(by: disposeBag)
    }

    func setupViewObservers() {
        input.view.fetchData
            .asObservable()
            .subscribe(with: self, onNext: { (self, _) in
                self.fetchCrypto()
            })
            .disposed(by: disposeBag)

        Observable.combineLatest(cells, input.view.searchText.startWith(nil).distinctUntilChanged())
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
        requestDisposable = dependencies.service.getTickers(params: params)
            .trackActivity(models.value.isEmpty ? output.view.activityIndicator : nil)
            .subscribe(with: self, onSuccess: { (self, response) in
                self.models.accept(response.tickers)
                self.output.view.errorMessageSubject.accept(nil)
            }, onFailure: { (self, error) in
                self.output.view.errorMessageSubject.accept(error.localizedDescription)
            }, onDisposed: { (self) in
                self.dependencies.timer.start()
            })
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

            fileprivate let cellViewModelsSubject = BehaviorRelay<[CellViewModel]>(value: [])
            fileprivate let errorMessageSubject = BehaviorRelay<String?>(value: nil)
        }
    }
}
