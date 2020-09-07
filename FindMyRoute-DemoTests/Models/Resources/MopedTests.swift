//
//  MopedTests.swift
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

class MopedTests: QuickSpec {

    override func spec() {

        describe("A moped") {
            var moped: Moped!
            beforeEach {
                moped = Moped(id: "0", name: "My moped",
                              x: -9, y: 40,
                              companyZoneId: 100, licencePlate: "0123ABC",
                              range: 100, batteryLevel: 80,
                              model: "Askoll", resourceImageId: "vehicle_gen_ecooltra",
                              realTimeData: true, resourceType: "MOPED",
                              helmets: 2)
            }

            it("is codable") {
                let data = try moped.encoded()
                let decoded = try data.decoded() as Moped

                expect(moped).to(equal(decoded))
            }

            it("has snippet") {
                expect(moped.snippet).notTo(beEmpty())
            }
        }

    }
}
