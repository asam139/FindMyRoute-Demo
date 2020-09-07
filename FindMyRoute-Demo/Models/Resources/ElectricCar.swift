//
//  ElectricCar.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

struct ElectricCar: PositionedResource {
    var id: String
    var name: String
    var x: Float
    var y: Float
    var companyZoneId: Int64

    var licencePlate: String
    var range: Int
    var batteryLevel: Int
    var model: String
    var resourceImageId: String
    var realTimeData: Bool
    var resourceType: String
    var seats: Int

    var snippet: String? {
        return "Battery Level: \(batteryLevel)%\nSeats: \(seats)"
    }
}
