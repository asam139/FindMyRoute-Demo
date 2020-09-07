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

        let city = City(id: "0", key: "lisboa", name: "Lisboa", x: -9.1604, y: 38.7452)

        describe("Decoded from JSON") {
            it("City") {

                let data = try city.encoded()
                let decodedCity = try data.decoded() as City

                expect(city).to(equal(decodedCity))
            }

            //            it("TrendingUser") {
            //                let data: [String: Any] = ["username": login, "name": name, "url": htmlUrl, "avatar": avatarUrl]
            //                let user = TrendingUser(JSON: data)
            //
            //                expect(user?.username) == login
            //                expect(user?.name) == name
            //                expect(user?.url) == htmlUrl
            //                expect(user?.avatar) == avatarUrl
            //            }
        }

        //        describe("user lifecycle") {
        //            it("save and remove user") {
        //                let data: [String: Any] = ["login": login, "name": name, "type": type, "created_at": createdAt, "html_url": htmlUrl, "avatar_url": avatarUrl]
        //                let user = User(JSON: data)
        //
        //                User.removeCurrentUser()
        //                expect(user?.isMine()) == false
        //
        //                user?.save()
        //                expect(user?.isMine()) == true
        //            }
        //        }
    }
}
