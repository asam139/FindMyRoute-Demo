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
import RxRelay
import RxGoogleMaps
import SnapKit
import NSObject_Rx

class MapViewController: ViewController {
    @IBOutlet weak var mapView: GMSMapView!
    let defaultRadius: CLLocationDistance = 250 // meters
    let defaultPadding: CGFloat = 5

    // TODO: Create cities selector
    lazy var city: BehaviorRelay<City> = {
        return BehaviorRelay(value: Config.initialCity)
    }()
    let region = PublishSubject<Region>()
    let resources = BehaviorRelay<[Resource]>(value: [])

    override func makeUI() {
        super.makeUI()

        let mapView = GMSMapView(frame: self.view.frame)
        mapView.isMyLocationEnabled = true

        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.mapView = mapView
    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? MapViewModel else { return }

        let input = MapViewModel.Input(city: city.asDriver(), refresh: region.asObservable())
        let output = viewModel.transform(input: input)

        mapView.rx.idleAt.map { [weak self] (_) -> Region? in
            guard let self = self else { return nil }
            let visibleRegion = self.mapView.projection.visibleRegion()
            return Region(lowerLeftLatLon: visibleRegion.nearLeft,
                          upperRightLatLon: visibleRegion.farRight)
        }.filterNil().bind(to: region).disposed(by: rx.disposeBag)

        input.city.asDriver().drive(onNext: { [weak self] (city) in
            self?.fitCameraBounds(city.position)
        }).disposed(by: rx.disposeBag)

        output.resources.bind(to: resources).disposed(by: rx.disposeBag)

        resources.asDriver(onErrorJustReturn: []).drive(onNext: { [weak self] (resources) in
            self?.updateResources(resources)
        }).disposed(by: rx.disposeBag)
    }

    func fitCameraBounds(_ coordinate: CLLocationCoordinate2D, animate: Bool = true) {
        let bounds = MapUtils.fitCameraBounds(coordinate: coordinate, radius: defaultRadius)
        let update = GMSCameraUpdate.fit(bounds, withPadding: defaultPadding)
        if animate {
            mapView.animate(with: update)
        } else {
            mapView.moveCamera(update)
        }
    }

    func updateResources(_ resources: [Resource]) {
        mapView.clear()
        resources.forEach { (resource) in
            let marker = GMSMarker()
            marker.position = resource.position
            marker.title = resource.name
            marker.snippet = resource.snippet
            marker.icon = ImagesManager.shared.markerImage(forKey: String(resource.companyZoneId))
            marker.map = mapView
        }
    }
}
