//
//  CryptoMarketplaceViewModelTests.swift
//  crypto-marketplaceTests
//
//  Created by Karol Majka on 21/06/2022.
//

import XCTest
import SwiftyMocky
import RxSwift
import RxTest
import RxBlocking

@testable import crypto_marketplace

final class CryptoMarketplaceViewModelTests: XCTestCase {

    private let serviceMock = BitfinexServiceProtocolMock()
    private let searchFilterMock = CryptoMarketplaceSearchFilterMock()
    private let timerMock = CryptoMarketplaceTimerContractorMock()
    private var notificationDispatcher: AppNotificationDispatcher!

    private var disposeBag = DisposeBag()
    private var scheduler: TestScheduler!
    private var firedSubject: PublishSubject<Void>!

    private var sut: CryptoMarketplaceViewModel!

    override func setUp() {
        super.setUp()
        notificationDispatcher = .init()
        firedSubject = .init()
        givenTimer()
        sut = .init(dependencies: .init(
            service: serviceMock,
            searchFilter: searchFilterMock,
            timer: timerMock,
            notificationDispatcher: notificationDispatcher
        ))
        scheduler = .init(initialClock: 0)
        disposeBag = .init()
    }

    override func tearDown() {
        sut = nil
        scheduler = nil
        serviceMock.resetMock()
        searchFilterMock.resetMock()
        timerMock.resetMock()
        super.tearDown()
    }

    func testFetchEmptyData() {
        let response: [BitfinexTicker] = []

        givenSearchFilter()
        givenServiceResponse(tickers: response)

        let cellViewModels = scheduler.createObserver(Int.self)
        sut.output.view.cellViewModels
            .map { $0.count }
            .drive(cellViewModels)
            .disposed(by: disposeBag)
        scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(cellViewModels.events, [
            .next(0, 0),
            .next(1, response.count),
            .next(2, response.count),
        ])
        serviceMock.verify(.getTickers(params: .any), count: 2)
        searchFilterMock.verify(.filter(model: .any, searchText: .any), count: .exactly(response.count * 2))
    }

    func testFetchData() {
        let response: [BitfinexTicker] = [
            buildModel(),
            buildModel(),
            buildModel(),
        ]

        givenSearchFilter()
        givenServiceResponse(tickers: response)

        let cellViewModels = scheduler.createObserver(Int.self)
        sut.output.view.cellViewModels
            .map { $0.count }
            .drive(cellViewModels)
            .disposed(by: disposeBag)
        scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(cellViewModels.events, [
            .next(0, 0),
            .next(1, response.count),
            .next(2, response.count),
        ])
        serviceMock.verify(.getTickers(params: .any), count: 2)
        searchFilterMock.verify(.filter(model: .any, searchText: .any), count: .exactly(response.count * 2))
    }

    func testSearchText() {
        let response: [BitfinexTicker] = [
            buildModel(),
            buildModel(),
        ]

        givenSearchFilter()
        givenServiceResponse(tickers: response)

        scheduler.createColdObservable([
            .next(1, ()),
            .next(4, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.createColdObservable([
            .next(2, "search"),
            .next(3, "text"),
        ])
            .bind(to: sut.input.view.searchText)
            .disposed(by: disposeBag)
        scheduler.start()

        serviceMock.verify(.getTickers(params: .any), count: 2)
        searchFilterMock.verify(.filter(model: .any, searchText: .value("search")), count: .exactly(response.count))
        searchFilterMock.verify(.filter(model: .any, searchText: .value("text")), count: .exactly(response.count * 2))
    }

    func testFilter() {
        let response: [BitfinexTicker] = [
            buildModel(),
            buildModel(),
        ]

        givenSearchFilter(willReturn: false)
        givenServiceResponse(tickers: response)

        let cellViewModels = scheduler.createObserver(Int.self)
        sut.output.view.cellViewModels
            .map { $0.count }
            .drive(cellViewModels)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(cellViewModels.events, [
            .next(0, 0),
            .next(1, 0),
            .next(2, 0),
        ])
        serviceMock.verify(.getTickers(params: .any), count: 2)
        searchFilterMock.verify(.filter(model: .any, searchText: .any), count: .exactly(response.count * 2))
    }

    func testTimer() {
        let response: [BitfinexTicker] = [
            buildModel(),
        ]

        givenSearchFilter()
        givenServiceResponse(tickers: response)

        let cellViewModels = scheduler.createObserver(Int.self)
        sut.output.view.cellViewModels
            .map { $0.count }
            .drive(cellViewModels)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(1, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.createColdObservable([
            .next(2, ()),
        ])
            .bind(to: firedSubject)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(cellViewModels.events, [
            .next(0, 0),
            .next(1, response.count),
            .next(2, response.count),
        ])
        serviceMock.verify(.getTickers(params: .any), count: 2)
    }

    func testErrorMessage() {
        let message = "Error message"
        let error = BitfinexError.server(error: .init(message: message))

        givenSearchFilter()
        givenServiceResponse(error: error)

        let errorMessage = scheduler.createObserver(String?.self)
        sut.output.view.errorMessage
            .drive(errorMessage)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(1, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(errorMessage.events, [
            .next(0, nil),
            .next(1, message),
        ])
    }

    func testErrorMessageClear() {
        let response: [BitfinexTicker] = [
            buildModel(),
        ]
        let message = "Error message"
        let error = BitfinexError.server(error: .init(message: message))

        givenSearchFilter()
        let apiResponse = BitfinexTickersResponse(tickers: response)
        serviceMock.given(.getTickers(params: .any, willReturn: .error(error), .just(apiResponse)))

        let cellViewModels = scheduler.createObserver(Int.self)
        sut.output.view.cellViewModels
            .map { $0.count }
            .drive(cellViewModels)
            .disposed(by: disposeBag)

        let errorMessage = scheduler.createObserver(String?.self)
        sut.output.view.errorMessage
            .drive(errorMessage)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(errorMessage.events, [
            .next(0, nil),
            .next(1, message),
            .next(2, nil),
        ])
        XCTAssertEqual(cellViewModels.events, [
            .next(0, 0),
            .next(2, response.count),
        ])
    }

    func testErrorMessageWithData() {
        let response: [BitfinexTicker] = [
            buildModel(),
        ]
        let message = "Error message"
        let error = BitfinexError.server(error: .init(message: message))

        givenSearchFilter()
        let apiResponse = BitfinexTickersResponse(tickers: response)
        serviceMock.given(.getTickers(params: .any, willReturn: .just(apiResponse), .error(error)))

        let cellViewModels = scheduler.createObserver(Int.self)
        sut.output.view.cellViewModels
            .map { $0.count }
            .drive(cellViewModels)
            .disposed(by: disposeBag)

        let errorMessage = scheduler.createObserver(String?.self)
        sut.output.view.errorMessage
            .drive(errorMessage)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(errorMessage.events, [
            .next(0, nil),
            .next(1, nil),
            .next(2, message),
        ])
        XCTAssertEqual(cellViewModels.events, [
            .next(0, 0),
            .next(1, response.count),
        ])
    }

    func testSceneDidBecomeActive() {
        let response: [BitfinexTicker] = []

        givenSearchFilter()
        givenServiceResponse(tickers: response)

        scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()
        notificationDispatcher.dispatch(.sceneDidBecomeActive)

        serviceMock.verify(.getTickers(params: .any), count: 3)
        timerMock.verify(.stop(), count: 0)
        timerMock.verify(.start(), count: 3)
    }

    func testSceneWillResignActive() {
        let response: [BitfinexTicker] = []

        givenSearchFilter()
        givenServiceResponse(tickers: response)

        scheduler.createColdObservable([
            .next(1, ()),
            .next(2, ()),
        ])
            .bind(to: sut.input.view.fetchData)
            .disposed(by: disposeBag)
        scheduler.start()
        notificationDispatcher.dispatch(.sceneWillResignActive)

        serviceMock.verify(.getTickers(params: .any), count: 2)
        timerMock.verify(.stop(), count: 1)
        timerMock.verify(.start(), count: 2)
    }

    private func givenServiceResponse(tickers: [BitfinexTicker]) {
        let response = BitfinexTickersResponse(tickers: tickers)
        serviceMock.given(.getTickers(params: .any, willReturn: .just(response)))
    }

    private func givenServiceResponse(error: Error) {
        serviceMock.given(.getTickers(params: .any, willReturn: .error(error)))
    }

    private func givenSearchFilter(willReturn: Bool = true) {
        searchFilterMock.given(.filter(model: .any, searchText: .any, willReturn: willReturn))
    }

    private func givenTimer() {
        timerMock.given(.fired(getter: firedSubject.asObservable()))
    }

    private func buildModel(coins: BitfinexCoinPair = (.btc, .usd)) -> BitfinexTicker {
        .init(
            symbol: "",
            coins: coins,
            ffr: nil,
            bid: 0,
            bidPeriod: nil,
            bidSize: 0,
            ask: 0,
            askPeriod: nil,
            askSize: 0,
            dailyChange: 0,
            dailyChangeRelative: 0,
            lastPrice: 0,
            volume: 0,
            high: 0,
            low: 0,
            frrAmountAvailable: nil
        )
    }
}
