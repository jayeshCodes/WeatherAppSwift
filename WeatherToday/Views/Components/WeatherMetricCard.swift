//
//  WeatherMetricCard.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI

struct WeatherMetricCard: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
        .background(.ultraThinMaterial.opacity(0.3))
        .cornerRadius(10)
    }
}
