//
//  CLLocationCoordinate2D+Extensions.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 4/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {
    var commaString: String {
        return "\(self.latitude),\(self.longitude)"
    }
}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}

public func !=(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude != rhs.latitude || lhs.longitude != rhs.longitude
}
