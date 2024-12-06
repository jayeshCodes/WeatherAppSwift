//
//  ContentView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import Foundation
import SwiftSpinner
import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: WeatherResponse?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            // Background Image Layer
                    Image("App_background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                if let location = locationManager.location {
                    if let weather = weather {
                        WeatherView(weather: weather)
                    } else {
                        LoadingView("Fetching weather...")
                            .task {
                                do {
                                    weather =
                                    try await weatherManager
                                        .getDailyForecast(
                                            latitude: location.latitude,
                                            longitude: location.longitude)
                                } catch {
                                    print(
                                        "Error fetching weather data: \(error)")
                                }
                            }
                    }
                } else {
                    if locationManager.isLoading {
                        LoadingView()
                    } else {
                        WelcomeView().environmentObject(locationManager)
                    }
                }
                
            }
        }
    }
}


// Add this preview helper at the bottom of ContentView.swift
#Preview("Loading State") {
    ContentView()
}

#Preview("Welcome View") {
    let locationManager = LocationManager()
    return ContentView(locationManager: locationManager)
}

#Preview("Weather View") {
    let mockWeather = WeatherResponse(
        location: Location(
            lat: "37.7749",
            lon: "-122.4194",
            city: "San Francisco",
            state: "California"
        ),
        timelines: [
            Timeline(
                time: "2024-12-06T00:00:00Z",
                values: WeatherValues(
                    temperature: 65.0,
                    temperatureMax: 72.0,
                    temperatureMin: 58.0,
                    humidity: 75.0,
                    windSpeed: 8.5,
                    precipitationProbability: 20.0,
                    weatherCode: 1000,
                    sunriseTime: "2024-12-06T06:45:00Z",
                    sunsetTime: "2024-12-06T17:45:00Z",
                    visibility: 10.0,
                    pressure: 29.92,
                    cloudCover: 25.0,
                    uvIndex: 5.0
                )
            )
        ]
    )
    
    let contentView = ContentView()
    contentView.weather = mockWeather
    contentView.locationManager.location = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    
    return contentView
}
