//
//  WelcomeView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to Weather Today!").bold().font(.title)

                Text(
                    "Please share your current location to get the weather in your area"
                ).padding()
            }.multilineTextAlignment(.center).padding()
            
            LocationButton(.shareCurrentLocation){
                locationManager.requestLocation()
            }.cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.black)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
