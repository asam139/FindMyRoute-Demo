//
//  MapViewModel.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MapViewModel: ViewModel, ViewModelType {

    struct Input {
        let refresh: Observable<Void>
    }

    struct Output {
        let city: BehaviorRelay<City>
        let resources: BehaviorRelay<[Resource]>
    }

    func transform(input: Input) -> Output {
        let city = BehaviorRelay<City>(value: Config.initialCity)
        let resources = BehaviorRelay<[Resource]>(value: [])

        input.refresh.flatMap { () -> Observable<[Resource]> in
            return self.request(city: city.value)
        }.subscribe(onNext: { (items) in
            resources.accept(items)
        }).disposed(by: rx.disposeBag)

        return Output(city: city, resources: resources)
    }

    func request(city: City) -> Observable<[Resource]> {
        return provider.resources(city: city.key).asObservable()
    }
}
