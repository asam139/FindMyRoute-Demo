//
//  MapViewControllerTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 9/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import NSObject_Rx
import RxBlocking
import GoogleMaps
@testable import FindMyRoute_Demo

class MapViewControllerTests: QuickSpec {
    override func spec() {
        describe("A map view") {
            var view: MapViewController!
            beforeEach {
                let provider = RestApi(meepProvider: MeepNetworking.stubbingNetworking())
                let viewModel = MapViewModel(provider: provider)
                let navigator = Navigator.default

                view = MapViewController(viewModel: viewModel, navigator: navigator)
                view.loadViewIfNeeded()
            }

            it("sets up the UI") {
                expect(view.mapView).toNot(beNil())
                expect(view.mapView?.bounds) != .zero

                expect { try view.resources.toBlocking().first() }.to(beEmpty())
            }

            it("refreshes resources") {
                expect { try view.resources.skip(1).toBlocking().first() }.notTo(beEmpty())
            }

            context("a new city is selected") {
                it("refreshes resources") {
                    let newCity = City(key: "madrid", name: "Madrid", x: -3.6919, y: 40.4188)
                    view.city.accept(newCity)

                    expect(view.city.value.id) == newCity.id
                    expect { try view.resources.skip(1).toBlocking().first() }.notTo(beEmpty())
                }
            }
        }
    }
}
