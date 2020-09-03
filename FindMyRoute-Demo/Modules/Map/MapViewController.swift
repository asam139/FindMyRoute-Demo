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
import RxSwift
import RxCocoa
import RxGoogleMaps
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

        let refresh = Observable.of(Observable.just(())).merge()
        let input = MapViewModel.Input(refresh: refresh)
        let output = viewModel.transform(input: input)

        //        mapView.rx.myLocation.filterNil().take(1).bind(onNext: { [weak self] (location) in
        //            self?.updateCameraPosition(coordinate: location.coordinate, animate: false)
        //        }).disposed(by: rx.disposeBag)

        mapView.rx.didChange.asDriver()
            .drive(onNext: { print("Did change position: \($0)") })
            .disposed(by: rx.disposeBag)

        output.city.asDriver().drive(onNext: { [weak self] (city) in
            self?.updateCameraPosition(coordinate: city.position)
        }).disposed(by: rx.disposeBag)

        output.resources.asDriver().drive(onNext: { [weak self] (resources) in
            self?.updateResources(resources)
        }).disposed(by: rx.disposeBag)
    }

    func updateCameraPosition(coordinate: CLLocationCoordinate2D, zoom: Float? = nil, animate: Bool = true) {

        let camera = GMSCameraPosition(target: coordinate, zoom: zoom ?? mapView.camera.zoom)
        if animate {
            mapView.animate(to: camera)
        } else {
            mapView.camera = camera
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
