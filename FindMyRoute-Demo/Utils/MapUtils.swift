//
//  MapUtils.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 3/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit
import GoogleMaps

class MapUtils {
    static func translateCoordinate(_ coordinate: CLLocationCoordinate2D, latMeters: CLLocationDistance, lonMeters: CLLocationDistance) -> (CLLocationCoordinate2D) {
        var newCoord = coordinate

        let tempRegion = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: latMeters,
                                            longitudinalMeters: lonMeters)
        let tempSpan = tempRegion.span

        newCoord.latitude = coordinate.latitude + tempSpan.latitudeDelta
        newCoord.longitude = coordinate.longitude + tempSpan.longitudeDelta

        return newCoord
    }

    static func fitCameraBounds(coordinate: CLLocationCoordinate2D,
                                radius: CLLocationDistance = 50) -> GMSCoordinateBounds {
        let diameter = radius * 2
        let range = MapUtils.translateCoordinate( coordinate, latMeters: diameter, lonMeters: diameter)
        return GMSCoordinateBounds(coordinate: coordinate, coordinate: range)
    }
}
