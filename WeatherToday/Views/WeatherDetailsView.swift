//
//  WeatherDetailsView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

enum WeatherTab {
    case today
    case weekly
    case weatherData
}

struct WeatherDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab = 0
    let weather: WeatherResponse
    let forecast15Day: TemperatureForecastResponse?

    var body: some View {
        NavigationView {
            
            TabView(selection: $selectedTab) {
                TodayTabView(weather: weather)
                    .tabItem {
                        Label("TODAY", systemImage: "calendar")
                    }
                    .tag(0)

                WeeklyTabView(weather: weather, forecast15Day: forecast15Day)
                    .tabItem {
                        Label("WEEKLY", systemImage: "chart.xyaxis.line")
                    }
                    .tag(1)

                WeatherDataTabView(weather: weather)
                    .tabItem {
                        Label("WEATHER DATA", systemImage: "thermometer")
                    }
                    .tag(2)
            }
            .navigationTitle(weather.location.city)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Weather")
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Twitter share functionality will go here
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
    }
}
