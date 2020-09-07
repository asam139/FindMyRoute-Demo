//
//  Resource.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

enum Resource: Decodable, PositionedResource {
    case busStop(BusStop)
    case bikeStop(BikeStop)
    case electricCar(ElectricCar)
    case moped(Moped)

    // Special keys to detect differents resources
    private enum CodingKeys: String, CodingKey {
        case scheduledArrival
        case bikesAvailable
        case resourceType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let _ = try? container.decode(Int64.self, forKey: .scheduledArrival) {
            self = .busStop(try BusStop(from: decoder))
        } else if let _ = try? container.decode(Int64.self, forKey: .bikesAvailable) {
            self = .bikeStop(try BikeStop(from: decoder))
        } else if let resourceType = try? container.decode(String.self, forKey: .resourceType) {
            switch resourceType {
            case "ELECTRIC_CAR": self = .electricCar(try ElectricCar(from: decoder))
            case "MOPED": self = .moped(try Moped(from: decoder))
            default: fatalError("Unknown type")
            }
        } else {
            fatalError("Unknown type")
        }
    }

    var id: String {
        switch self {
        case .busStop(let r):
            return r.id
        case .bikeStop(let r):
            return r.id
        case .electricCar(let r):
            return r.id
        case .moped(let r):
            return r.id
        }
    }

    var name: String {
        switch self {
        case .busStop(let r):
            return r.name
        case .bikeStop(let r):
            return r.name
        case .electricCar(let r):
            return r.name
        case .moped(let r):
            return r.name
        }
    }

    var x: Float {
        switch self {
        case .busStop(let r):
            return r.x
        case .bikeStop(let r):
            return r.x
        case .electricCar(let r):
            return r.x
        case .moped(let r):
            return r.x
        }
    }

    var y: Float {
        switch self {
        case .busStop(let r):
            return r.y
        case .bikeStop(let r):
            return r.y
        case .electricCar(let r):
            return r.y
        case .moped(let r):
            return r.y
        }
    }

    var companyZoneId: Int64 {
        switch self {
        case .busStop(let r):
            return r.companyZoneId
        case .bikeStop(let r):
            return r.companyZoneId
        case .electricCar(let r):
            return r.companyZoneId
        case .moped(let r):
            return r.companyZoneId
        }
    }

    var snippet: String? {
        switch self {
        case .busStop(let r):
            return r.snippet
        case .bikeStop(let r):
            return r.snippet
        case .electricCar(let r):
            return r.snippet
        case .moped(let r):
            return r.snippet
        }
    }
}
