//
//  RestApi.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa
import Moya
import Alamofire

typealias MoyaError = Moya.MoyaError

class RestApi: MainApi {
    let meepProvider: MeepNetworking

    init(meepProvider: MeepNetworking) {
        self.meepProvider = meepProvider
    }

    func resources(cityKey: String, region: Region) -> Single<[Resource]> {
        return request(.resources(cityKey: cityKey, region: region))
    }
}

extension RestApi {
    private func request<T: Decodable>(_ target: MeepApi) -> Single<T> {
        return meepProvider.request(target)
            .map(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}
