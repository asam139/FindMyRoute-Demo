//
//  BusStopTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Codextended
@testable import FindMyRoute_Demo

class BusStopTests: QuickSpec {

    override func spec() {

        describe("A bus stop") {
            var busStop: BusStop!
            beforeEach {
                busStop = BusStop(id: "0", name: "My bus stop",
                                  x: -9, y: 40,
                                  companyZoneId: 100,
                                  scheduledArrival: 0, locationType: 0,
                                  lat: -9, lon: 40)
            }

            it("is codable") {
                let data = try busStop.encoded()
                let decodedBusStop = try data.decoded() as BusStop

                expect(busStop).to(equal(decodedBusStop))
            }

            it("has snippet") {
                expect(busStop.snippet).notTo(beEmpty())
            }
        }
    }

}
