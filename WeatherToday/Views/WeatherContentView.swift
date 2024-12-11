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
    @ObservedObject var favoritesManager: FavoritesManager
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    @State private var showingDetails = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // First Sub View - Main Weather Card
                Button(action: {
                    showingDetails = true
                }) {
                    HStack(spacing: 0) {
                        // Weather Icon Section (1/3 of space)
                        Image(systemName: getWeatherIconName(weather.timelines[0].values.weatherCode))
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.25)
                        
                        // Weather Details Section (2/3 of space)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(Int(weather.timelines[0].values.temperature))°F")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(.white)
                            
                            Text(getWeatherDescription(weather.timelines[0].values.weatherCode))
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            Text(weather.location.city)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 8)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .foregroundColor(.primary)
                
                // Weather Metrics
                WeatherMetricsView(weather: weather)
                
                // Forecast Table
                if let forecast = forecast15Day {
                    ForecastView(forecast: forecast, dailyForecast: weather)
                        .frame(maxHeight: .infinity)
                }
            }
            .padding(.vertical)
        }
        .sheet(isPresented: $showingDetails) {
            WeatherDetailsView(
                weather: weather,
                forecast15Day: forecast15Day,
                favoritesManager: favoritesManager,
                showToast: $showToast,
                toastMessage: $toastMessage
            )
        }
    }
}
