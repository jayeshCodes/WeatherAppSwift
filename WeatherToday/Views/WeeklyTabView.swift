//
//  WeeklyTabView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct WeeklyTabView: View {
    let weather: WeatherResponse
    let forecast15Day: TemperatureForecastResponse?

    var body: some View {
        ZStack {
            // Background Image Layer
            Image("App_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                Spacer().frame(height: 50)
                VStack(spacing: 20) {
                    // Weather Summary Card
                    WeatherSummaryCard(weather: weather)
                        .padding(.horizontal)

                    Spacer()
                    // Temperature Chart
                    if let forecast = forecast15Day {
                        TemperatureChartView(forecast: forecast)
                            .frame(height: 300)
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}
