//
//  CityTests.swift
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

class CityTests: QuickSpec {

    override func spec() {

        describe("A city") {
            it("is identifiable") {
                let city = City(key: "lisboa", name: "Lisboa", x: -9.1604, y: 38.7452)
                expect(city.id).notTo(beEmpty())
            }

            it("is codable") {
                let city = City(id: "0", key: "lisboa", name: "Lisboa", x: -9.1604, y: 38.7452)
                let data = try city.encoded()
                let decodedCity = try data.decoded() as City

                expect(city) == decodedCity
            }
        }
    }
}
