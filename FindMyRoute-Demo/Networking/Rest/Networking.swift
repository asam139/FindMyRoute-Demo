//
//  Networking.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }

    static func defaultNetworking() -> Self
    static func stubbingNetworking() -> Self
}

extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return endpoint
        }
    }

    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }

    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        #if DEBUG
        plugins.append(NetworkLoggerPlugin())
        #endif
        return plugins
    }

    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                logError(error.localizedDescription)
            }
        }
    }
}

struct MeepNetworking: NetworkingType {
    typealias T = MeepApi
    let provider: OnlineProvider<T>

    static func defaultNetworking() -> Self {
        return MeepNetworking(provider: newProvider(plugins))
    }

    static func stubbingNetworking() -> Self {
        return MeepNetworking(provider:
                                OnlineProvider(
                                    endpointClosure: endpointsClosure(),
                                    requestClosure: MeepNetworking.endpointResolver(),
                                    stubClosure: MoyaProvider.immediatelyStub, online: .just(true)
                                )
        )
    }

    func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> /*where T: ArtsyAPIType*/ {
    return OnlineProvider(endpointClosure: MeepNetworking.endpointsClosure(xAccessToken),
                          requestClosure: MeepNetworking.endpointResolver(),
                          stubClosure: MeepNetworking.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}
