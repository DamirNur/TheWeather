//
//  LocationManager.swift
//  TheWeather
//
//  Created by Damir Nuriev on 18.03.2024.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

struct Location: Equatable {
    let latitude: Double
    let longitude: Double
    
    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> Observable<Location> {
        return Observable.create { observer in
            if let location = self.locationManager.location {
                let currentLocation = Location(from: location.coordinate)
                observer.onNext(currentLocation)
                observer.onCompleted()
            } else {
                observer.onError(NSError(domain: "Location not available", code: 0, userInfo: nil))
            }
            return Disposables.create()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated: \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed with error: \(error)")
    }
}
