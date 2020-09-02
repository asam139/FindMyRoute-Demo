//
//  Resource.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit

class Resource: Codable {
    var id: String
    var name: String
    var scheduledArrival: Int64
    var locationType: Int64
    var companyZoneId: Int64

    var x: Float
    var y: Float
    var lat: Float
    var lon: Float

    var position: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(lon))
    }
}
