//
//  WeatherTodayApp.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI
import SwiftData
import UIKit

@main
struct WeatherAppApp: App {
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherManager = WeatherManager()
    @StateObject var autoCompleteManager = AutocompleteManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
    }
}
