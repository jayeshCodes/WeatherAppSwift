//
//  TodayTabView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct TodayTabView: View {
    let weather: WeatherResponse
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        ZStack {
            // Background Image Layer
            Image("App_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Spacer().frame(height: 50)
                LazyVGrid(columns: columns, spacing: 15) {
                    // Maintain same order as shown in image
                    WeatherMetricCard(
                        icon: "wind",
                        value: String(format: "%.1f mph", weather.timelines[0].values.windSpeed),
                        label: "Wind Speed"
                    )
                    
                    WeatherMetricCard(
                        icon: "gauge",
                        value: String(format: "%.2f inHg", weather.timelines[0].values.pressure),
                        label: "Pressure"
                    )
                    
                    WeatherMetricCard(
                        icon: "cloud.rain",
                        value: "\(Int(weather.timelines[0].values.precipitationProbability))%",
                        label: "Precipitation"
                    )
                    
                    WeatherMetricCard(
                        icon: "thermometer",
                        value: "\(Int(weather.timelines[0].values.temperature))°F",
                        label: "Temperature"
                    )
                    
                    // Weather Condition in center
                    WeatherMetricCard(
                        icon: getWeatherIconName(weather.timelines[0].values.weatherCode),
                        value: getWeatherDescription(weather.timelines[0].values.weatherCode),
                        label: "Conditions"
                    )
                    
                    WeatherMetricCard(
                        icon: "humidity",
                        value: "\(Int(weather.timelines[0].values.humidity))%",
                        label: "Humidity"
                    )
                    
                    WeatherMetricCard(
                        icon: "eye.fill",
                        value: String(format: "%.1f mi", weather.timelines[0].values.visibility),
                        label: "Visibility"
                    )
                    
                    WeatherMetricCard(
                        icon: "cloud.fill",
                        value: "\(Int(weather.timelines[0].values.cloudCover))%",
                        label: "Cloud Cover"
                    )
                    
                    WeatherMetricCard(
                        icon: "sun.max.fill",
                        value: "\(Int(weather.timelines[0].values.uvIndex))",
                        label: "UV Index"
                    )
                }
                .padding()
            }
        }
    }
}
