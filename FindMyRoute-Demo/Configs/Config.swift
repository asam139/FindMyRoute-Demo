//
//  Config.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 1/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation

// MARK: API
enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let meepBaseURL: URL = {
        guard let urlString = Config.infoDictionary["MEEP_BASE_URL"] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: urlString) else {
            fatalError("Root URL not set in plist for this environment")
        }
        return url
    }()

    static let googleMapsApiKey: String = {
        guard let apiKey = Config.infoDictionary["GOOGLE_MAPS_API_KEY"] as? String else {
            fatalError("Stripe API Key not set in plist for this environment")
        }
        return apiKey
    }()

    static let initialCity = City(id: "0", key: "lisboa", name: "Lisboa", x: -9.160096, y: 38.71104)
}
