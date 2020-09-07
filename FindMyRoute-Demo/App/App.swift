//
//  App.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 7/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import UIKit

final class Application: NSObject {
    static let shared = Application()

    var window: UIWindow?

    var provider: MainApi!
    let navigator: Navigator!

    private override init() {
        provider = RestApi(meepProvider: MeepNetworking.defaultNetworking())
        navigator = Navigator.default
        super.init()
        updateProvider()
    }

    private func updateProvider() {

    }

    func presentInitialScreen(in window: UIWindow?) {
        updateProvider()
        guard let window = window, let provider = provider else { return }
        self.window = window

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let viewModel = MapViewModel(provider: provider)
            self?.navigator.show(segue: .map(viewModel: viewModel), sender: nil, transition: .root(in: window))
        }
    }
}
