//
//  Positioned.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 3/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit

protocol Positioned: Decodable {
    var id: String { get }
    var name: String { get }
    var x: Float { get }
    var y: Float { get }
}

extension Positioned {
    var position: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(y), longitude: Double(x))
    }
}

protocol PositionedResource: Positioned {
    var companyZoneId: Int64 { get }
}
