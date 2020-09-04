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

struct BusStop: PositionedResource {
    var id: String
    var name: String
    var x: Float
    var y: Float
    var companyZoneId: Int64

    var scheduledArrival: Int64
    var locationType: Int64
    var lat: Float
    var lon: Float

    var snippet: String? {
        return "Bus Station\n Scheduled Arrival: \(scheduledArrival > 0 ? String(scheduledArrival) : "-")"
    }
}

struct BikeStop: PositionedResource {
    var id: String
    var name: String
    var x: Float
    var y: Float
    var companyZoneId: Int64

    var realTimeData: Bool
    var station: Bool
    var availableResources: Int
    var spacesAvailable: Int
    var allowDropoff: Bool

    var bikesAvailable: Int

    var snippet: String? {
        return "Available Bikes: \(bikesAvailable)\nAvailable Spaces: \(spacesAvailable)"
    }
}

struct ElectricCar: PositionedResource {
    var id: String
    var name: String
    var x: Float
    var y: Float
    var companyZoneId: Int64

    var licencePlate: String
    var range: Int
    var batteryLevel: Int
    var model: String
    var resourceImageId: String
    var realTimeData: Bool
    var resourceType: String
    var seats: Int

    var snippet: String? {
        return "Battery Level: \(batteryLevel)%\nSeats: \(seats)"
    }
}

struct Moped: PositionedResource {
    var id: String
    var name: String
    var x: Float
    var y: Float
    var companyZoneId: Int64

    var licencePlate: String
    var range: Int
    var batteryLevel: Int
    var model: String
    var resourceImageId: String
    var realTimeData: Bool
    var resourceType: String

    var helmets: Int

    var snippet: String? {
        return "Battery Level: \(batteryLevel)%\nHelmets: \(helmets)"
    }
}
