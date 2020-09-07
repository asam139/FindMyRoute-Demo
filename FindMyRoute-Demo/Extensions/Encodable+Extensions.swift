//
//  Encodable+Extensions.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

extension Encodable {
    typealias Serialization = JSONSerialization

    func asParemeters() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dict = try Serialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dict
    }

    var parameters: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? Serialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] ?? [:]
    }
}
