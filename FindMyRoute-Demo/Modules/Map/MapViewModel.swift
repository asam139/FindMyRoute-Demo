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
    }

    struct Output {
        let items: BehaviorRelay<[Resource]>
    }

    func transform(input: Input) -> Output {

        let elements = BehaviorRelay<[Resource]>(value: [])

        return Output(items: elements)
    }

    func request() -> Observable<[Resource]> {
        return provider.resources(city: "Lisboa").asObservable()
    }
}
