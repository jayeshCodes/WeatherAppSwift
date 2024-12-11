//
//  WeatherDetailsView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftSpinner
import SwiftUI

enum WeatherTab {
    case today
    case weekly
    case weatherData
}

struct WeatherDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab = 0
    let weather: WeatherResponse
    let forecast15Day: TemperatureForecastResponse?
    @ObservedObject var favoritesManager: FavoritesManager
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    
    var body: some View {
        ZStack {
            // Background Image Layer
            Image("App_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                TabView(selection: $selectedTab) {
                    TodayTabView(weather: weather)
                        .tabItem {
                            Label {
                                Text("TODAY")
                            } icon: {
                                Image("Today_Tab")
                                    .renderingMode(.template)
                            }
                        }
                        .tag(0)
                        .background(.ultraThinMaterial)
                    
                    WeeklyTabView(
                        weather: weather, forecast15Day: forecast15Day
                    )
                    .tabItem {
                        Label {
                            Text("WEEKLY")
                        } icon: {
                            Image("Weekly_Tab")
                                .renderingMode(.template)
                        }
                    }
                    .tag(1)
                    .background(.ultraThinMaterial)
                    
                    WeatherDataTabView(weather: weather)
                        .tabItem {
                            Label {
                                Text("WEATHER DATA")
                            } icon: {
                                Image("Weather_Data_Tab")
                                    .renderingMode(.template)
                            }
                        }
                        .tag(2)
                        .background(.ultraThinMaterial)
                }
                .navigationTitle(weather.location.city)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Weather")
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action: {
                                toggleFavorite()
                            }) {
                                Image(
                                    isFavorite ? "close-circle" : "plus-circle"
                                )
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                            }
                            
                            Button(action: {
                                shareToTwitter()
                            }) {
                                Image("twitter")
                                    .renderingMode(.template)
                                    .foregroundColor(Color.accentColor) // This will match the system blue color used by the back button
                                    .frame(width: 24, height: 24)
                            }
                            .tint(.accentColor)
                        }
                    }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            //            .onAppear {
            //                UINavigationBar.appearance().setBackgroundImage(
            //                    UIImage(), for: .default)
            //                UINavigationBar.appearance().shadowImage = UIImage()
            //                UINavigationBar.appearance().backgroundColor = .clear
            //                UITabBar.appearance().backgroundColor = .clear
            //            }
        }
    }
    
    private var isFavorite: Bool {
        favoritesManager.favorites.contains { favorite in
            favorite.city == weather.location.city
            && favorite.state == weather.location.state
        }
    }
    
    private func toggleFavorite() {
        Task {
            SwiftSpinner.show("Updating favorites...")
            
            let isFavorite = await favoritesManager.checkFavorite(
                city: weather.location.city,
                state: weather.location.state
            )
            
            if isFavorite {
                if let favorite = favoritesManager.favorites.first(where: {
                    $0.city == weather.location.city
                    && $0.state == weather.location.state
                }) {
                    let success = await favoritesManager.removeFavorite(
                        id: favorite.id)
                    if success {
                        toastMessage =
                        "\(weather.location.city) removed from favorites"
                        showToast = true
                    }
                }
            } else {
                let success = await favoritesManager.addFavorite(
                    city: weather.location.city,
                    state: weather.location.state
                )
                if success {
                    toastMessage = "\(weather.location.city) added to favorites"
                    showToast = true
                }
            }
            
            SwiftSpinner.hide()
        }
    }
    
    private func shareToTwitter() {
        let text =
        "Check out the weather in \(weather.location.city)! Temperature: \(Int(weather.timelines[0].values.temperature))°F, Conditions: \(getWeatherDescription(weather.timelines[0].values.weatherCode))"
        let encodedText =
        text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        ?? ""
        let twitterURL = URL(
            string: "https://twitter.com/intent/tweet?text=\(encodedText)")!
        UIApplication.shared.open(twitterURL)
    }
}
