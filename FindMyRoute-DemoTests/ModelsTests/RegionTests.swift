//
//  RegionTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Codextended
import MapKit
@testable import FindMyRoute_Demo

class RegionTests: QuickSpec {

    override func spec() {

        describe("A region") {
            let lowerLeftLatLon = CLLocationCoordinate2D(latitude: -10, longitude: 40)
            let upperRightLatLon = CLLocationCoordinate2D(latitude: -9, longitude: 41)

            it("is codable") {
                let region = Region(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon)
                let data = try region.encoded()
                let decodedRegion = try data.decoded() as Region

                expect(region) == decodedRegion
            }
        }
    }

}
