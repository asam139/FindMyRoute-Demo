//
//  City.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 3/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

class City: Positioned {
    var id: String
    var key: String
    var name: String

    var x: Float
    var y: Float

    var snippet: String?

    init(id: String? = nil, key: String, name: String, x: Float, y: Float) {
        self.id = id ?? UUID().uuidString
        self.key = key
        self.name = name
        self.x = x
        self.y = y
    }
}
