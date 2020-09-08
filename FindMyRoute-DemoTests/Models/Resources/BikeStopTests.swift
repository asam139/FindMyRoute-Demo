//
//  BikeStopTests.swift
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

class BikeStopTests: QuickSpec {

    override func spec() {

        describe("A bike stop") {
            var bikeStop: BikeStop!
            beforeEach {
                bikeStop = BikeStop(id: "0", name: "My bike stop",
                                    x: -9, y: 40,
                                    companyZoneId: 100, realTimeData: true,
                                    station: true, availableResources: 10,
                                    spacesAvailable: 10, allowDropoff: true,
                                    bikesAvailable: 5)
            }

            it("is codable") {
                let data = try bikeStop.encoded()
                let decoded = try data.decoded() as BikeStop

                expect(bikeStop) == decoded
            }

            it("has snippet") {
                expect(bikeStop.snippet).notTo(beEmpty())
            }
        }

    }
}
