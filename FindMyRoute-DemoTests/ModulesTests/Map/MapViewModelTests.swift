//
//  MapViewModelTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 8/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import NSObject_Rx
import RxBlocking
import MapKit
@testable import FindMyRoute_Demo

class MapViewModelTests: QuickSpec {
    override func spec() {
        var provider: RestApi!  // used stubbing responses

        var viewModel: MapViewModel!
        var city: BehaviorRelay<City>!
        var refresh: PublishSubject<Region>!
        var output: MapViewModel.Output!

        beforeEach {
            provider = RestApi(meepProvider: MeepNetworking.stubbingNetworking())

            city = BehaviorRelay<City>(value: Config.initialCity)
            refresh = PublishSubject<Region>()

            viewModel = MapViewModel(provider: provider)
            let input = MapViewModel.Input(city: city.asDriver(), refresh: refresh.asObservable())
            output = viewModel.transform(input: input)
        }

        afterEach {
            // Deallocate
            viewModel = nil
        }

        describe("A map view model") {
            it("starts empty") {
                expect(output.resources.value).to(beEmpty())
            }

            context("when refreshes the region") {
                it("new resources appear") {
                    refresh.onNext(Region(lowerLeftLatLon: CLLocationCoordinate2D(latitude: -9, longitude: 40),
                                          upperRightLatLon: CLLocationCoordinate2D(latitude: -10, longitude: 41)))
                    expect(output.resources.value).toNot(beEmpty())
                }
            }
        }
    }
}
