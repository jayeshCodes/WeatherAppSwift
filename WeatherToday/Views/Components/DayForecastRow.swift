//
//  DayForecastRow.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct DayForecastRow: View {
    let timeline: Timeline
    
    private func formatTimeOnly(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = formatter.date(from: dateString) else { return "" }
        
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    var body: some View {
        HStack {
            // Date
            Text(formatDate(timeline.time))
                .frame(width: 100, alignment: .leading)
                .foregroundColor(.white)
            
            // Weather icon
            Image(systemName: getWeatherIconName(timeline.values.weatherCode))
                .frame(width: 30)
                .foregroundColor(.white)
            
            Spacer()
            
            // Sunrise info
            Image("sun-rise")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Text(formatTimeOnly(timeline.values.sunriseTime))
                .frame(width: 50)
                .foregroundColor(.white)
            
            // Sunset info
            Image("sun-set")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Text(formatTimeOnly(timeline.values.sunsetTime))
                .frame(width: 50)
                .foregroundColor(.white)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}
