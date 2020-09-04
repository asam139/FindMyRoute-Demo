//
//  CLLocationCoordinate2D+Extensions.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 4/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    var commaString: String {
        return "\(self.latitude),\(self.longitude)"
    }
}
