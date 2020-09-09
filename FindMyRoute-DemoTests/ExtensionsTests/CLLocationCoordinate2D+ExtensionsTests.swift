//
//  CLLocationCoordinate2D+ExtensionsTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 9/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Codextended
import MapKit
@testable import FindMyRoute_Demo

class CLLocationCoordinate2DExtensionsTests: QuickSpec {

    override func spec() {

        describe("A coordinate") {
            it("can be compared") {
                let firstC = CLLocationCoordinate2D(latitude: -10, longitude: 40)
                let secondC = CLLocationCoordinate2D(latitude: -9, longitude: 41)
                expect(firstC) == firstC
                expect(firstC) != secondC
            }
        }
    }

}
