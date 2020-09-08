//
//  ImagesManagerTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 8/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import FindMyRoute_Demo

class ImagesManagerTests: QuickSpec {

    override func spec() {

        describe("A images manager") {

            var manager: ImagesManager!
            beforeEach {
                manager = ImagesManager()
            }

            afterEach {
                manager = nil
            }

            it("creates a new marker if it don't exist") {
                let image = manager.markerImage(forKey: "012345678")
                expect(image.size.width) > 0
                expect(image.size.height) > 0
            }

            it("does not create a new image if it is cached") {
                let key = "012345678"
                let image = manager.markerImage(forKey: key)
                expect(image) == manager.markerImage(forKey: key)
            }
        }
    }
}
