//
//  ViewModelTypeTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 8/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxSwift
import RxCocoa
import NSObject_Rx
import RxBlocking
import RxTest
@testable import FindMyRoute_Demo

class ViewModelTypeTests: QuickSpec {

    override func spec() {
        var provider: RestApi!  // used stubbing responses
        var viewModel: ViewModel!

        beforeEach {
            provider = RestApi(meepProvider: MeepNetworking.stubbingNetworkingWithErrors())
            viewModel = ViewModel(provider: provider)
        }

        afterEach {
            viewModel = nil
        }

        describe("a view model") {
            it("stores server errors") {
                let error = CocoaError.init(.userCancelled)

                let scheduler = TestScheduler(initialClock: 0, resolution: 1)
                scheduler.scheduleAt(10) {
                    viewModel.serverError.onNext(error)
                }

                let observer = scheduler.record(
                    viewModel.serverError.asObservable(),
                    disposeBag: self.rx.disposeBag
                )
                scheduler.start()

                expect(observer.events.count) > 0
                expect(observer.events.first?.value.element as? CocoaError) == error

            }

            it("parses errors") {
                let error = MoyaError.requestMapping("Test Error")

                let scheduler = TestScheduler(initialClock: 0, resolution: 1)
                scheduler.scheduleAt(10) {
                    viewModel.serverError.onNext(error)
                }

                let observer = scheduler.record(
                    viewModel.parsedError.asObservable(),
                    disposeBag: self.rx.disposeBag
                )
                scheduler.start()

                expect(observer.events.count) > 0
                expect(expression: { () -> Int? in
                    let moyaError = observer.events.first?.value.element
                    return moyaError?.errorCode
                }) == error.errorCode
            }
        }
    }

}
