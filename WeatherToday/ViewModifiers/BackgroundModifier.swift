//
//  BackgroundModifier.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            // Background layer that ignores safe areas
            Image("App_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Content layer
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Extension to make it easier to use
extension View {
    func withAppBackground() -> some View {
        modifier(BackgroundModifier())
    }
}
