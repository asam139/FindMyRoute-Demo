//
//  ViewController.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 1/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }

}
