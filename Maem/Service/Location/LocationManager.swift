//
//  LocationManager.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import CoreLocation
import Observation

@Observable
final class LocationManager: NSObject {

    private let manager = CLLocationManager()

    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var currentLocation: CLLocation?

    override init() {

        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        authorizationStatus = manager.authorizationStatus

    }

    func requestLocationPermission() {

        switch authorizationStatus {

        case .notDetermined:

            manager.requestWhenInUseAuthorization()

        case .authorizedAlways,
             .authorizedWhenInUse:

            manager.requestLocation()

        case .restricted,
             .denied:

            break

        @unknown default:

            break

        }

    }

    func refreshLocation() {

        guard authorizationStatus == .authorizedAlways ||
              authorizationStatus == .authorizedWhenInUse
        else {
            return
        }

        manager.requestLocation()

    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {

        authorizationStatus = manager.authorizationStatus

        switch authorizationStatus {

        case .authorizedAlways,
             .authorizedWhenInUse:

            manager.requestLocation()

        default:

            break

        }

    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        currentLocation = locations.first

    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        print(error.localizedDescription)

    }

}
