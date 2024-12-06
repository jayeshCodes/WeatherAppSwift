//
//  ContentView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: WeatherResponse?
    var body: some View {
        ZStack {
            Image("App_background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()

            VStack {

                if let location = locationManager.location {
                    if let weather = weather {
                        WeatherView(weather: weather)
                    } else {
                        Text("fetching weather data")
                        LoadingView()
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
