//
//  Region.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 4/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit

struct Region: Codable {
    var lowerLeftLatLon: CLLocationCoordinate2D
    var upperRightLatLon: CLLocationCoordinate2D

    enum CodingKeys: String, CodingKey {
        case lowerLeftLatLon
        case upperRightLatLon
    }

    init(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D) {
        self.lowerLeftLatLon = lowerLeftLatLon
        self.upperRightLatLon = upperRightLatLon
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let lowerLeftLatLonString = try container.decode(String.self, forKey: .lowerLeftLatLon)
        let upperRightLatLonString = try container.decode(String.self, forKey: .upperRightLatLon)

        let lowerLeftLatLonArray = lowerLeftLatLonString.split(separator: ",")
        let upperRightLatLonArray = upperRightLatLonString.split(separator: ",")
        lowerLeftLatLon = CLLocationCoordinate2D(latitude: CLLocationDegrees(lowerLeftLatLonArray[0])!,
                                                 longitude: CLLocationDegrees(lowerLeftLatLonArray[1])!)
        upperRightLatLon = CLLocationCoordinate2D(latitude: CLLocationDegrees(upperRightLatLonArray[0])!,
                                                  longitude: CLLocationDegrees(upperRightLatLonArray[1])!)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lowerLeftLatLon.commaString, forKey: .lowerLeftLatLon)
        try container.encode(upperRightLatLon.commaString, forKey: .upperRightLatLon)
    }
}
