// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 3.5.0

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import Foundation
import RxSwift
@testable import crypto_marketplace


// MARK: - AppNotificationObserver
open class AppNotificationObserverMock: AppNotificationObserver, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func appNotificationReceived(_ notification: AppNotification) {
        addInvocation(.m_appNotificationReceived__notification(Parameter<AppNotification>.value(`notification`)))
		let perform = methodPerformValue(.m_appNotificationReceived__notification(Parameter<AppNotification>.value(`notification`))) as? (AppNotification) -> Void
		perform?(`notification`)
    }

    open func registerForAppNotifications() {
        addInvocation(.m_registerForAppNotifications)
		let perform = methodPerformValue(.m_registerForAppNotifications) as? () -> Void
		perform?()
    }

    open func unregisterFromAppNotifications() {
        addInvocation(.m_unregisterFromAppNotifications)
		let perform = methodPerformValue(.m_unregisterFromAppNotifications) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_appNotificationReceived__notification(Parameter<AppNotification>)
        case m_registerForAppNotifications
        case m_unregisterFromAppNotifications

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_appNotificationReceived__notification(let lhsNotification), .m_appNotificationReceived__notification(let rhsNotification)):
                guard Parameter.compare(lhs: lhsNotification, rhs: rhsNotification, with: matcher) else { return false } 
                return true 
            case (.m_registerForAppNotifications, .m_registerForAppNotifications):
                return true 
            case (.m_unregisterFromAppNotifications, .m_unregisterFromAppNotifications):
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_appNotificationReceived__notification(p0): return p0.intValue
            case .m_registerForAppNotifications: return 0
            case .m_unregisterFromAppNotifications: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func appNotificationReceived(_ notification: Parameter<AppNotification>) -> Verify { return Verify(method: .m_appNotificationReceived__notification(`notification`))}
        public static func registerForAppNotifications() -> Verify { return Verify(method: .m_registerForAppNotifications)}
        public static func unregisterFromAppNotifications() -> Verify { return Verify(method: .m_unregisterFromAppNotifications)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func appNotificationReceived(_ notification: Parameter<AppNotification>, perform: @escaping (AppNotification) -> Void) -> Perform {
            return Perform(method: .m_appNotificationReceived__notification(`notification`), performs: perform)
        }
        public static func registerForAppNotifications(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_registerForAppNotifications, performs: perform)
        }
        public static func unregisterFromAppNotifications(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_unregisterFromAppNotifications, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - BitfinexServiceProtocol
open class BitfinexServiceProtocolMock: BitfinexServiceProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getTickers(params: BitfinexTickersParams) -> Single<BitfinexTickersResponse> {
        addInvocation(.m_getTickers__params_params(Parameter<BitfinexTickersParams>.value(`params`)))
		let perform = methodPerformValue(.m_getTickers__params_params(Parameter<BitfinexTickersParams>.value(`params`))) as? (BitfinexTickersParams) -> Void
		perform?(`params`)
		var __value: Single<BitfinexTickersResponse>
		do {
		    __value = try methodReturnValue(.m_getTickers__params_params(Parameter<BitfinexTickersParams>.value(`params`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getTickers(params: BitfinexTickersParams). Use given")
			Failure("Stub return value not specified for getTickers(params: BitfinexTickersParams). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getTickers__params_params(Parameter<BitfinexTickersParams>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_getTickers__params_params(let lhsParams), .m_getTickers__params_params(let rhsParams)):
                guard Parameter.compare(lhs: lhsParams, rhs: rhsParams, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getTickers__params_params(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getTickers(params: Parameter<BitfinexTickersParams>, willReturn: Single<BitfinexTickersResponse>...) -> MethodStub {
            return Given(method: .m_getTickers__params_params(`params`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getTickers(params: Parameter<BitfinexTickersParams>, willProduce: (Stubber<Single<BitfinexTickersResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<BitfinexTickersResponse>] = []
			let given: Given = { return Given(method: .m_getTickers__params_params(`params`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<BitfinexTickersResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getTickers(params: Parameter<BitfinexTickersParams>) -> Verify { return Verify(method: .m_getTickers__params_params(`params`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getTickers(params: Parameter<BitfinexTickersParams>, perform: @escaping (BitfinexTickersParams) -> Void) -> Perform {
            return Perform(method: .m_getTickers__params_params(`params`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - CryptoMarketplaceSearchFilter
open class CryptoMarketplaceSearchFilterMock: CryptoMarketplaceSearchFilter, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func filter(model: BitfinexTicker, searchText: String?) -> Bool {
        addInvocation(.m_filter__model_modelsearchText_searchText(Parameter<BitfinexTicker>.value(`model`), Parameter<String?>.value(`searchText`)))
		let perform = methodPerformValue(.m_filter__model_modelsearchText_searchText(Parameter<BitfinexTicker>.value(`model`), Parameter<String?>.value(`searchText`))) as? (BitfinexTicker, String?) -> Void
		perform?(`model`, `searchText`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_filter__model_modelsearchText_searchText(Parameter<BitfinexTicker>.value(`model`), Parameter<String?>.value(`searchText`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for filter(model: BitfinexTicker, searchText: String?). Use given")
			Failure("Stub return value not specified for filter(model: BitfinexTicker, searchText: String?). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_filter__model_modelsearchText_searchText(Parameter<BitfinexTicker>, Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_filter__model_modelsearchText_searchText(let lhsModel, let lhsSearchtext), .m_filter__model_modelsearchText_searchText(let rhsModel, let rhsSearchtext)):
                guard Parameter.compare(lhs: lhsModel, rhs: rhsModel, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsSearchtext, rhs: rhsSearchtext, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_filter__model_modelsearchText_searchText(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func filter(model: Parameter<BitfinexTicker>, searchText: Parameter<String?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_filter__model_modelsearchText_searchText(`model`, `searchText`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func filter(model: Parameter<BitfinexTicker>, searchText: Parameter<String?>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_filter__model_modelsearchText_searchText(`model`, `searchText`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func filter(model: Parameter<BitfinexTicker>, searchText: Parameter<String?>) -> Verify { return Verify(method: .m_filter__model_modelsearchText_searchText(`model`, `searchText`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func filter(model: Parameter<BitfinexTicker>, searchText: Parameter<String?>, perform: @escaping (BitfinexTicker, String?) -> Void) -> Perform {
            return Perform(method: .m_filter__model_modelsearchText_searchText(`model`, `searchText`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - CryptoMarketplaceTimerContractor
open class CryptoMarketplaceTimerContractorMock: CryptoMarketplaceTimerContractor, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var fired: Observable<Void> {
		get {	invocations.append(.p_fired_get); return __p_fired ?? givenGetterValue(.p_fired_get, "CryptoMarketplaceTimerContractorMock - stub value for fired was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_fired = newValue }
	}
	private var __p_fired: (Observable<Void>)?





    open func start() {
        addInvocation(.m_start)
		let perform = methodPerformValue(.m_start) as? () -> Void
		perform?()
    }

    open func stop() {
        addInvocation(.m_stop)
		let perform = methodPerformValue(.m_stop) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_start
        case m_stop
        case p_fired_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_start, .m_start):
                return true 
            case (.m_stop, .m_stop):
                return true 
            case (.p_fired_get,.p_fired_get): return true
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_start: return 0
            case .m_stop: return 0
            case .p_fired_get: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func fired(getter defaultValue: Observable<Void>...) -> PropertyStub {
            return Given(method: .p_fired_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func start() -> Verify { return Verify(method: .m_start)}
        public static func stop() -> Verify { return Verify(method: .m_stop)}
        public static var fired: Verify { return Verify(method: .p_fired_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func start(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_start, performs: perform)
        }
        public static func stop(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_stop, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

