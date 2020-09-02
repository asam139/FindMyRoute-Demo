//
//  ViewModelType.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 2/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional
import NSObject_Rx

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class ViewModel: NSObject {

    let provider: MainApi

    let serverError = PublishSubject<Error>()
    let parsedError = PublishSubject<MoyaError>()

    init(provider: MainApi) {
        self.provider = provider
        super.init()

        serverError
            .asObservable()
            .map { $0 as? MoyaError }
            .filterNil()
            .bind(to: parsedError)
            .disposed(by: rx.disposeBag)

        parsedError.subscribe(onNext: { (error) in
            logError("\(error)")
        }).disposed(by: rx.disposeBag)
    }

    deinit {
        logDebug("Deinit: \(type(of: self))")
    }
}
