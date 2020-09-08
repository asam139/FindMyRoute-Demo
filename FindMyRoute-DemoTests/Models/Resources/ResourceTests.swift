//
//  ResourceTests.swift
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

class ResourceTests: QuickSpec {

    override func spec() {

        describe("A resource") {
            it("can be a bus stop") {
                let busStop = BusStop(id: "0", name: "My bus stop",
                                      x: -9, y: 40,
                                      companyZoneId: 100,
                                      scheduledArrival: 0, locationType: 0,
                                      lat: -9, lon: 40)
                let data = try busStop.encoded()
                let decoded = try data.decoded() as Resource

                switch decoded {
                case .busStop(let stop):
                    expect(busStop) == stop
                    expect(try decoded.encoded().decoded() as BusStop) == stop
                default:
                    fail("Expecting a bus stop")
                    break
                }

                expect(busStop.id) == decoded.id
                expect(busStop.name) == decoded.name
                expect(busStop.x) == decoded.x
                expect(busStop.y) == decoded.y
                expect(busStop.companyZoneId) == decoded.companyZoneId
                expect(busStop.snippet) == decoded.snippet
                expect(busStop.position) == decoded.position
            }

            it("can be a bike stop") {
                let bikeStop = BikeStop(id: "0", name: "My bike stop",
                                        x: -9, y: 40,
                                        companyZoneId: 100, realTimeData: true,
                                        station: true, availableResources: 10,
                                        spacesAvailable: 10, allowDropoff: true,
                                        bikesAvailable: 5)
                let data = try bikeStop.encoded()
                let decoded = try data.decoded() as Resource

                switch decoded {
                case .bikeStop(let stop):
                    expect(bikeStop) == stop
                    expect(try decoded.encoded().decoded() as BikeStop) == stop
                default:
                    fail("Expecting a bike stop")
                    break
                }

                expect(bikeStop.id) == decoded.id
                expect(bikeStop.name) == decoded.name
                expect(bikeStop.x) == decoded.x
                expect(bikeStop.y) == decoded.y
                expect(bikeStop.companyZoneId) == decoded.companyZoneId
                expect(bikeStop.snippet) == decoded.snippet
                expect(bikeStop.position) == decoded.position
            }

            it("can be a electric car") {
                let electricCar = ElectricCar(id: "0", name: "My electric car",
                                              x: -9, y: 40, companyZoneId: 100,
                                              licencePlate: "0123ABC", range: 100,
                                              batteryLevel: 80, model: "DS3",
                                              resourceImageId: "vehicle_gen_emov", realTimeData: true,
                                              resourceType: "ELECTRIC_CAR", seats: 5)
                let data = try electricCar.encoded()
                let decoded = try data.decoded() as Resource

                switch decoded {
                case .electricCar(let car):
                    expect(electricCar) == car
                    expect(try decoded.encoded().decoded() as ElectricCar) == electricCar
                default:
                    fail("Expecting a electric car")
                    break
                }

                expect(electricCar.id) == decoded.id
                expect(electricCar.name) == decoded.name
                expect(electricCar.x) == decoded.x
                expect(electricCar.y) == decoded.y
                expect(electricCar.companyZoneId) == decoded.companyZoneId
                expect(electricCar.snippet) == decoded.snippet
                expect(electricCar.position) == decoded.position
            }

            it("can be a moped") {
                let moped = Moped(id: "0", name: "My moped",
                                  x: -9, y: 40,
                                  companyZoneId: 100, licencePlate: "0123ABC",
                                  range: 100, batteryLevel: 80,
                                  model: "Askoll", resourceImageId: "vehicle_gen_ecooltra",
                                  realTimeData: true, resourceType: "MOPED",
                                  helmets: 2)
                let data = try moped.encoded()
                let decoded = try data.decoded() as Resource

                switch decoded {
                case .moped(let m):
                    expect(moped) == m
                    expect(try decoded.encoded().decoded() as Moped) == moped
                default:
                    fail("Expecting a moped")
                    break
                }

                expect(moped.id) == decoded.id
                expect(moped.name) == decoded.name
                expect(moped.x) == decoded.x
                expect(moped.y) == decoded.y
                expect(moped.companyZoneId) == decoded.companyZoneId
                expect(moped.snippet) == decoded.snippet
                expect(moped.position) == decoded.position
            }

            it("only can be specific types") {
                let moped = Moped(id: "0", name: "My WRONG Moped",
                                  x: 0, y: 0,
                                  companyZoneId: 100, licencePlate: "0000AAA",
                                  range: 0, batteryLevel: 0,
                                  model: "", resourceImageId: "",
                                  realTimeData: true, resourceType: "WRONG_TYPE",
                                  helmets: 1)
                let data = try moped.encoded()

                expect { _ = try data.decoded() as Resource }.to(throwAssertion())
            }
        }
    }

}
