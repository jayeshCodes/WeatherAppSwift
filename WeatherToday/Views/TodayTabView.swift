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
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                // Wind Speed
                WeatherMetricCard(
                    icon: "wind",
                    value: String(format: "%.2f mph", weather.timelines[0].values.windSpeed),
                    label: "Wind Speed"
                )
                
                // Pressure
                WeatherMetricCard(
                    icon: "gauge",
                    value: "29.92 inHG",
                    label: "Pressure"
                )
                
                // Precipitation
                WeatherMetricCard(
                    icon: "cloud.rain",
                    value: "\(Int(weather.timelines[0].values.precipitationProbability))%",
                    label: "Precipitation"
                )
                
                // Temperature
                WeatherMetricCard(
                    icon: "thermometer",
                    value: "\(Int(weather.timelines[0].values.temperature))°F",
                    label: "Temperature"
                )
                
                // Weather Condition
                WeatherMetricCard(
                    icon: getWeatherIconName(weather.timelines[0].values.weatherCode),
                    value: getWeatherDescription(weather.timelines[0].values.weatherCode),
                    label: "Conditions"
                )
                
                // Humidity
                WeatherMetricCard(
                    icon: "humidity",
                    value: "\(Int(weather.timelines[0].values.humidity))%",
                    label: "Humidity"
                )
                
                // Visibility
                WeatherMetricCard(
                    icon: "eye.fill",
                    value: "9.94 mi",
                    label: "Visibility"
                )
                
                // Cloud Cover
                WeatherMetricCard(
                    icon: "cloud.fill",
                    value: "100%",
                    label: "Cloud Cover"
                )
                
                // UV Index
                WeatherMetricCard(
                    icon: "sun.max.fill",
                    value: "10",
                    label: "UV Index"
                )
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

// Preview Provider
struct TodayTabView_Previews: PreviewProvider {
    static var sampleWeather: WeatherResponse = {
        // Create a sample weather response for preview
        let timeline = Timeline(
            time: "2024-12-05T00:00:00Z",
            values: WeatherValues(
                temperature: 72.5,
                temperatureMax: 75.0,
                temperatureMin: 70.0,
                humidity: 85.0,
                windSpeed: 12.0,
                precipitationProbability: 30.0,
                weatherCode: 1001
            )
        )
        
        return WeatherResponse(
            location: Location(
                lat: "34.0522",
                lon: "-118.2437",
                city: "Los Angeles",
                state: "California"
            ),
            timelines: [timeline]
        )
    }()
    
    static var previews: some View {
        TodayTabView(weather: sampleWeather)
    }
}
