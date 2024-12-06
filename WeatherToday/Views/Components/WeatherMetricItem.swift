//
//  WeatherMetricItem.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct WeatherMetricItem: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
            Text(value)
                .font(.system(size: 14))
            Text(label)
                .font(.system(size: 12))
        }
        .frame(maxWidth: .infinity)
    }
}
