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
    let defaultRadius: Float = 250 // meters
    let defaultPadding: Float = 50 // meters

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

        output.city.asDriver().drive(onNext: { [weak self] (city) in
            self?.fitCameraBounds(city.position)
        }).disposed(by: rx.disposeBag)

        output.resources.asDriver().drive(onNext: { [weak self] (resources) in
            self?.updateResources(resources)
        }).disposed(by: rx.disposeBag)
    }

    func fitCameraBounds(_ coordinate: CLLocationCoordinate2D, animate: Bool = true) {
        let range = MapUtils.translateCoordinate(coordinate: coordinate, latMeters: Double(defaultRadius * 2), lonMeters: Double(defaultRadius * 2))
        let bounds = GMSCoordinateBounds(coordinate: coordinate, coordinate: range)
        let update = GMSCameraUpdate.fit(bounds, withPadding: defaultPadding)
        if animate {
            mapView.animate(with: update)
        } else {
            mapView.moveCamera(update)
        }
    }

    func updateCameraPosition(coordinate: CLLocationCoordinate2D, animate: Bool = true) {
        let camera = GMSCameraPosition(target: coordinate, zoom: mapView.camera.zoom)
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
