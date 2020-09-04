//
//  ImagesManager.swift
//  FindMyRoute-Demo
//
//  Created by Saul Moreno Abril on 4/9/20.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import Foundation
import RandomColorSwift
import GoogleMaps

class ImagesManager {
    static let shared = ImagesManager()

    private lazy var imagesCache: NSCache<NSString, AnyObject> = {
        let cache = NSCache<NSString, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()

    private let config: Config

    struct Config {
        let countLimit: Int

        static let defaultConfig = Config(countLimit: 100)
    }

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }

    func markerImage(forKey key: String) -> UIImage {
        if let image = imagesCache.object(forKey: key as NSString) as? UIImage {
            return image
        }

        let color = randomColor(hue: .random, luminosity: .bright)
        let image = GMSMarker.markerImage(with: color)
        imagesCache.setObject(image, forKey: key as NSString)
        return image
    }
}
