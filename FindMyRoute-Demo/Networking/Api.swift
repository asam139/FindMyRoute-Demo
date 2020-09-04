//
//  Api.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

protocol MainApi {

    // MARK: - Meep
    func resources(cityKey: String, lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D) -> Single<[Resource]>
}
