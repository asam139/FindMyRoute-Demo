//
//  Encodable+ExtensionsTests.swift
//  FindMyRoute-DemoTests
//
//  Created by Saul Moreno Abril on 9/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import XCTest

import XCTest
import Quick
import Nimble
import Codextended
@testable import FindMyRoute_Demo

class EncodableExtensionsTests: QuickSpec {

    struct EncodableStruct: Encodable {
        var name: String = "Test"
    }

    struct NoDictStruct: Encodable {
        var name: String = "Test"

        func encode(to encoder: Encoder) throws {
            try encoder.encodeSingleValue([name])
        }
    }

    struct NoEncodableStruct: Encodable {
        var name: String = "Test"

        func encode(to encoder: Encoder) throws {
            throw NSError(domain: "", code: 100, userInfo: nil)
        }
    }

    override func spec() {

        describe("A encodable object") {

            context("as parameters throwing") {
                it("encodes all properties") {
                    let encodable = EncodableStruct()
                    let parameters = try encodable.asParemeters()
                    expect(parameters["name"] as? String) == encodable.name
                }

                it("manages invalid objects") {
                    let encodable = NoDictStruct()
                    expect { _ = try encodable.asParemeters() }.to(throwError())
                }
            }

            context("as parameters") {
                it("encodes all properties") {
                    let encodable = EncodableStruct()
                    let parameters = encodable.parameters
                    expect(parameters["name"] as? String) == encodable.name
                }

                it("manages invalid objects") {
                    let noEncodable = NoEncodableStruct()
                    expect(noEncodable.parameters).to(beEmpty())

                    let noDict = NoDictStruct()
                    expect(noDict.parameters).to(beEmpty())
                }
            }
        }
    }
}
