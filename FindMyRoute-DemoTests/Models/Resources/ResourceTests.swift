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
                    expect(busStop).to(equal(stop))
                    expect(try decoded.encoded().decoded() as BusStop).to(equal(stop))
                default:
                    fail("Expecting a bus stop")
                    break
                }

                expect(busStop.id).to(equal(decoded.id))
                expect(busStop.name).to(equal(decoded.name))
                expect(busStop.x).to(equal(decoded.x))
                expect(busStop.y).to(equal(decoded.y))
                expect(busStop.companyZoneId).to(equal(decoded.companyZoneId))
                expect(busStop.snippet).to(equal(decoded.snippet))
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
                    expect(bikeStop).to(equal(stop))
                    expect(try decoded.encoded().decoded() as BikeStop).to(equal(stop))
                default:
                    fail("Expecting a bike stop")
                    break
                }

                expect(bikeStop.id).to(equal(decoded.id))
                expect(bikeStop.name).to(equal(decoded.name))
                expect(bikeStop.x).to(equal(decoded.x))
                expect(bikeStop.y).to(equal(decoded.y))
                expect(bikeStop.companyZoneId).to(equal(decoded.companyZoneId))
                expect(bikeStop.snippet).to(equal(decoded.snippet))
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
                    expect(electricCar).to(equal(car))
                    expect(try decoded.encoded().decoded() as ElectricCar).to(equal(electricCar))
                default:
                    fail("Expecting a electric car")
                    break
                }

                expect(electricCar.id).to(equal(decoded.id))
                expect(electricCar.name).to(equal(decoded.name))
                expect(electricCar.x).to(equal(decoded.x))
                expect(electricCar.y).to(equal(decoded.y))
                expect(electricCar.companyZoneId).to(equal(decoded.companyZoneId))
                expect(electricCar.snippet).to(equal(decoded.snippet))
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
                    expect(moped).to(equal(m))
                    expect(try decoded.encoded().decoded() as Moped).to(equal(moped))
                default:
                    fail("Expecting a moped")
                    break
                }

                expect(moped.id).to(equal(decoded.id))
                expect(moped.name).to(equal(decoded.name))
                expect(moped.x).to(equal(decoded.x))
                expect(moped.y).to(equal(decoded.y))
                expect(moped.companyZoneId).to(equal(decoded.companyZoneId))
                expect(moped.snippet).to(equal(decoded.snippet))
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
