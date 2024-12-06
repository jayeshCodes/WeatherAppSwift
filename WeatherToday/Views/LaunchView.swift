//
//  LaunchView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            // Background
            Color(red: 135/255, green: 206/255, blue: 235/255)
                .ignoresSafeArea()
            
            // Cloud pattern background (optional)
            Image("App_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Weather Icon
                Image("Partly Cloudy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                // Tomorrow.io Logo
                Image("Powered_by_Tomorrow-Black")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.bottom, 50)
            }
        }
    }
}
#Preview {
    LaunchView()
}
