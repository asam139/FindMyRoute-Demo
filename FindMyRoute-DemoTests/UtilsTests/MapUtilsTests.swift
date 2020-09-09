//
//  MapUtils.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 9/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import XCTest
import Quick
import Nimble
import MapKit
@testable import FindMyRoute_Demo

class MapUtilsTests: QuickSpec {
    override func spec() {

        describe("Map utils") {
            it("translates coordinate") {
                let solution = CLLocationCoordinate2D(latitude: 10.001808191392588,
                                                      longitude: 10.001824162898572)
                let input = CLLocationCoordinate2D(latitude: 10, longitude: 10)
                let meters: CLLocationDistance = 200

                let output = MapUtils.translateCoordinate(input, latMeters: meters, lonMeters: meters)
                expect(output) == solution
            }

            it("fits camera bounds") {

                let input = CLLocationCoordinate2D(latitude: 10, longitude: 10)
                let radius: CLLocationDistance = 100

                let output = MapUtils.fitCameraBounds(coordinate: input, radius: radius)
                expect(output.contains(input)) == true
            }
        }
    }
}
