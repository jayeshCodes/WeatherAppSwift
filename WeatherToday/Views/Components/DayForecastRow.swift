//
//  DayForecastRow.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct DayForecastRow: View {
    let timeline: TemperatureTimeline

    var body: some View {
        HStack {
            Text(formatDate(timeline.time))
                .frame(width: 100, alignment: .leading)

            Image(systemName: "sun.max.fill")
                .frame(width: 30)

            Spacer()

            Text("\(Int(timeline.values.temperatureMax))°")
                .frame(width: 40)

            Text("\(Int(timeline.values.temperatureMin))°")
                .frame(width: 40)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}
