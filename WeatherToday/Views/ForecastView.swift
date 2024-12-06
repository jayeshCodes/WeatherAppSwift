//
//  ForecastView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct ForecastView: View {
    let forecast: TemperatureForecastResponse?
    let dailyForecast: WeatherResponse?
    
    private func combinedTimelines() -> [(date: String, temp: TemperatureValues, daily: Timeline?)] {
        guard let forecast = forecast else { return [] }
        
        return forecast.timelines.map { tempTimeline in
            let matchingDaily = dailyForecast?.timelines.first { timeline in
                // Compare dates without time
                let tempDate = formatDate(tempTimeline.time)
                let dailyDate = formatDate(timeline.time)
                return tempDate == dailyDate
            }
            
            return (
                date: tempTimeline.time,
                temp: tempTimeline.values,
                daily: matchingDaily
            )
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(combinedTimelines(), id: \.date) { combined in
                    if let daily = combined.daily {
                        DayForecastRow(timeline: daily)
                    } else {
                        // Fallback view with just temperature data
                        HStack {
                            Text(formatDate(combined.date))
                                .frame(width: 100, alignment: .leading)
                            
                            Image(systemName: "sun.max.fill")
                                .frame(width: 30)
                            
                            Spacer()
                            
                            Text("\(Int(combined.temp.temperatureMax))°")
                                .frame(width: 40)
                            
                            Text("\(Int(combined.temp.temperatureMin))°")
                                .frame(width: 40)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                    }
                    Divider()
                }
            }
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}
