//
//  BikeStop.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

struct BikeStop: PositionedResource {
    var id: String
    var name: String
    var x: Float
    var y: Float
    var companyZoneId: Int64

    var realTimeData: Bool
    var station: Bool
    var availableResources: Int
    var spacesAvailable: Int
    var allowDropoff: Bool

    var bikesAvailable: Int

    var snippet: String? {
        return "Available Bikes: \(bikesAvailable)\nAvailable Spaces: \(spacesAvailable)"
    }
}
