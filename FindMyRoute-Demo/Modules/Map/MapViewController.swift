//
//  MapViewController.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 1/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import RxGoogleMaps
import RxCocoa
import SnapKit
import NSObject_Rx

class MapViewController: UIViewController {

    var viewModel: MapViewModel?

    @IBOutlet weak var mapView: GMSMapView!

    init(viewModel: MapViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = MapViewModel(provider: AppDelegate.shared.provider)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        bindViewModel()
    }

    func makeUI() {
        let mapView = GMSMapView(frame: self.view.frame)
        mapView.isMyLocationEnabled = true

        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.mapView = mapView
    }

    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        let input = MapViewModel.Input()
        let output = viewModel.transform(input: input)

        self.mapView.rx.myLocation.filterNil().take(1).bind(onNext: { [weak self] (location) in
            self?.updateCameraPosition(location: location, animate: false)
        }).disposed(by: rx.disposeBag)

        self.mapView.rx.didChange.asDriver()
            .drive(onNext: { print("Did change position: \($0)") })
            .disposed(by: rx.disposeBag)

        output.items.asDriver(onErrorJustReturn: []).drive(onNext: { [weak self] (resources) in
            self?.updateResources(resources)
        }).disposed(by: rx.disposeBag)
    }

    func updateCameraPosition(location: CLLocation, animate: Bool = true) {
        let camera = GMSCameraPosition(target: location.coordinate, zoom: self.mapView.camera.zoom)
        if animate {
            self.mapView.animate(to: camera)
        } else {
            self.mapView.camera = camera
        }
    }

    func updateResources(_ resources: [Resource]) {
        mapView.clear()
        resources.forEach { (resource) in
            let marker = GMSMarker()
            marker.position = resource.position
            marker.title = resource.name
            //marker.snippet = "Lisboa"
            marker.map = mapView
        }
    }
}
