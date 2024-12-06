//
//  WeatherMetricsView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct WeatherMetricsView: View {
    let weather: WeatherResponse
    
    var body: some View {
        HStack(spacing: 20) {
            WeatherMetricItem(
                icon: "drop.fill",
                value: String(format: "%.0f%%", weather.timelines[0].values.humidity),
                label: "Humidity")
            WeatherMetricItem(
                icon: "wind",
                value: String(format: "%.1f mph", weather.timelines[0].values.windSpeed),
                label: "Wind Speed")
            WeatherMetricItem(
                icon: "eye.fill",
                value: String(format: "%.1f mi", weather.timelines[0].values.visibility),
                label: "Visibility")
            WeatherMetricItem(
                icon: "gauge",
                value: String(format: "%.2f inHg", weather.timelines[0].values.pressure),
                label: "Pressure")
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
