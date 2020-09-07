//
//  ElectricCarTests.swift
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

class ElectricCarTests: QuickSpec {

    override func spec() {

        describe("A electric car") {
            var car: ElectricCar!
            beforeEach {
                car = ElectricCar(id: "0", name: "My electric car",
                                  x: -9, y: 40, companyZoneId: 100,
                                  licencePlate: "0123ABC", range: 100,
                                  batteryLevel: 80, model: "DS3",
                                  resourceImageId: "vehicle_gen_emov", realTimeData: true,
                                  resourceType: "ELECTRIC_CAR", seats: 5)
            }

            it("is codable") {
                let data = try car.encoded()
                let decoded = try data.decoded() as ElectricCar

                expect(car).to(equal(decoded))
            }

            it("has snippet") {
                expect(car.snippet).notTo(beEmpty())
            }
        }

    }
}
