//
//  ViewController.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 9/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import Hero

class ViewController: UIViewController, Navigatable {

    var viewModel: ViewModel?
    var navigator: Navigator!

    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()

        // Did become active notification
        NotificationCenter.default
            .rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] (_) in
                self?.didBecomeActive()
        }.disposed(by: rx.disposeBag)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }

    deinit {
        logDebug("Deinit: \(type(of: self))")
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        logDebug("\(type(of: self)): Received Memory Warning")
    }

    func makeUI() {
        hero.isEnabled = true
        updateUI()
    }

    func bindViewModel() {

    }

    func updateUI() {

    }

    func didBecomeActive() {
        self.updateUI()
    }
}
