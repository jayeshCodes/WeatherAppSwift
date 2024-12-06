//
//  WeatherContentView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct WeatherContentView: View {
    let weather: WeatherResponse
    let forecast15Day: TemperatureForecastResponse?
    @State private var showingDetails = false
    
    var body: some View {
        VStack(spacing: 16) {
            // First Sub View - Main Weather Card
            Button(action: {
                showingDetails = true
            }) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top) {
                        Image(systemName: getWeatherIconName(weather.timelines[0].values.weatherCode))
                            .font(.title)
                        Text("\(Int(weather.timelines[0].values.temperature))°F")
                            .font(.system(size: 40))
                    }
                    Text(getWeatherDescription(weather.timelines[0].values.weatherCode))
                        .font(.title3)
                    Text(weather.location.city)
                        .font(.title2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .foregroundColor(.primary)
            .sheet(isPresented: $showingDetails) {
                WeatherDetailsView(weather: weather, forecast15Day: forecast15Day)
            }
            
            WeatherMetricsView(weather: weather)
            ForecastView(forecast: forecast15Day)
        }
    }
}
