//
//  Dictionary+Extensions.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge(_ other: [Key : Value]) {
        return self.merge(other) { (_, new) in new }
    }
}
