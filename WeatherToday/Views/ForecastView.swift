//
//  ForecastView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct ForecastView: View {
    let forecast: TemperatureForecastResponse?
    
    var body: some View {
        if let forecast = forecast {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(forecast.timelines, id: \.time) { day in
                        DayForecastRow(timeline: day)
                        Divider()
                    }
                }
                .background(.ultraThinMaterial)
                .cornerRadius(12)
            }
            .padding(.horizontal)
        }
    }
}
