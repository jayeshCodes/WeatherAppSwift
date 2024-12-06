//
//  LocationManager.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }

    // Default to Los Angeles coordinates if outside US
    let defaultLocation = CLLocationCoordinate2D(
        latitude: 34.0522, longitude: -118.2437)

    func locationManager(
        _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first?.coordinate else {
            self.location = defaultLocation
            isLoading = false
            return
        }

        // Check if location is within US boundaries (approximately)
        let isInUS =
            location.latitude >= 24.396308  // Southern tip of Florida
            && location.latitude <= 49.384358  // Northern border
            && location.longitude >= -125.000000  // Western border
            && location.longitude <= -66.934570  // Eastern border

        self.location = isInUS ? location : defaultLocation // ensure location is always within the US
//        self.location = isInUS ? defaultLocation : location // for debugging purposes
        isLoading = false
    }

    func locationManager(
        _ manager: CLLocationManager, didFailWithError error: any Error
    ) {
        print("Error getting location", error)
        isLoading = false
    }
}
