//
//  MapViewModel.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

class MapViewModel: ViewModel, ViewModelType {

    struct Input {
        let city: Driver<City>
        let refresh: Observable<Region>
    }

    struct Output {
        let resources: BehaviorRelay<[Resource]>
    }

    func transform(input: Input) -> Output {
        let resources = BehaviorRelay<[Resource]>(value: [])

        let throttledRefresh = input.refresh.throttle(.milliseconds(250), scheduler: MainScheduler.instance)

        let results = Observable
            .combineLatest(input.city.asObservable(), throttledRefresh)
            .flatMapLatest { (city, region) -> Observable<[Resource]> in
                print("City-Region", city, region)
                return self.request(city: city, region: region)
        }
        results.bind(to: resources).disposed(by: rx.disposeBag)
        return Output(resources: resources)
    }

    func request(city: City, region: Region) -> Observable<[Resource]> {
        return provider.resources(cityKey: city.key, region: region).asObservable()
    }
}
