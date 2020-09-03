//
//  City.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 3/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

class City: Codable {
    var id: String
    var key: String
    var name: String

    var x: Float
    var y: Float
    var lat: Float
    var lon: Float

    init(id: String, key: String, name: String,
         lat: Float, lon: Float,
         x: Float? = nil, y: Float? = nil) {
        self.id = id
        self.key = key
        self.name = name
        self.x = x ?? lat
        self.y = y ?? lon
        self.lat = lat
        self.lon = lon
    }
}
