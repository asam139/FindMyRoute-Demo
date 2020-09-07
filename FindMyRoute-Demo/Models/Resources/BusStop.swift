//
//  BusStop.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

struct BusStop: PositionedResource {
    var id: String
    var name: String
    var x: Float
    var y: Float
    var companyZoneId: Int64

    var scheduledArrival: Int64
    var locationType: Int64
    var lat: Float
    var lon: Float

    var snippet: String? {
        return "Bus Station\n Scheduled Arrival: \(scheduledArrival > 0 ? String(scheduledArrival) : "-")"
    }
}
