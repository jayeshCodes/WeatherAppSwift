//
//  WeatherDataTabView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct WeatherDataTabView: View {
    let weather: WeatherResponse
    
    var body: some View {
        ZStack{
            Image("App_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                
            ScrollView {
                Spacer().frame(height: 50)
                VStack(spacing: 20) {
                    // Key Data Summary Card
                    VStack(spacing: 16) {
                        HStack(spacing: 30) {
                            // Precipitation
                            WeatherMetricItem(
                                icon: "cloud.rain",
                                value: "\(Int(weather.timelines[0].values.precipitationProbability))%",
                                label: "Precipitation"
                            )
                            
                            // Humidity
                            WeatherMetricItem(
                                icon: "humidity",
                                value: "\(Int(weather.timelines[0].values.humidity))%",
                                label: "Humidity"
                            )
                            
                            // Cloud Cover - Now using actual value
                            WeatherMetricItem(
                                icon: "cloud.fill",
                                value: "\(Int(weather.timelines[0].values.cloudCover))%",
                                label: "Cloud Cover"
                            )
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Activity Gauge Chart with actual cloud cover value
                    ActivityGaugeChart(
                        precipitation: weather.timelines[0].values.precipitationProbability,
                        humidity: weather.timelines[0].values.humidity,
                        cloudCover: weather.timelines[0].values.cloudCover
                    )
                    .frame(height: 400)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
}
