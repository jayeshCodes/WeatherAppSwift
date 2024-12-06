//
//  WeatherSummaryCard.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct WeatherSummaryCard: View {
    let weather: WeatherResponse
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: getWeatherIconName(weather.timelines[0].values.weatherCode))
                .font(.system(size: 40))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(getWeatherDescription(weather.timelines[0].values.weatherCode))
                    .font(.title3)
                Text("\(Int(weather.timelines[0].values.temperature))°F")
                    .font(.title)
            }
            
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}
