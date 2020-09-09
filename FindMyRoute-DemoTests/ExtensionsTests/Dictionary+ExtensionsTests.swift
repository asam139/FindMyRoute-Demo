//
//  Dictionary+ExtensionsTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 9/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Quick
import Nimble
import Codextended
import MapKit
@testable import FindMyRoute_Demo

class DictionaryExtensionsTests: QuickSpec {

    override func spec() {

        describe("A dictionary") {
            it("can be merged") {
                var dict = ["key0": "value0"]
                let newDict = ["key0": "newValue0", "key1": "newValue1"]

                dict.merge(newDict)
                expect(dict["key0"]) == newDict["key0"]
                expect(dict["key1"]) == newDict["key1"]
            }
        }
    }

}
