//
//  MeepApi.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

enum MeepApi {
    case resources(city: String)
}

extension MeepApi: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return Config.meepBaseURL
        }
    }

    var path: String {
        switch self {
        case .resources(let city): return "routers/\(city)/resources"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .resources:
            params["lowerLeftLatLon"] = "38.711046,-9.1600096"
            params["upperRightLatLon"] = "38.739429,-9.137115"
        }
        return params
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }

    var sampleData: Data {
        var dataUrl: URL?
        /*switch self {
         case .routes: dataUrl = ...
         }*/
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
    }
}
