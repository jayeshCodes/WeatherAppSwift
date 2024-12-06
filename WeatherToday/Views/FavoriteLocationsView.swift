//
//  FavoriteLocationsView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import SwiftUI

struct FavoriteLocationsView: View {
    @StateObject private var weatherManager = WeatherManager()
    @StateObject private var favoritesManager = FavoritesManager()
    @StateObject private var autocompleteManager = AutocompleteManager()
    @State private var currentPage = 0
    @State private var weatherData: [String: WeatherResponse] = [:]
    @State private var forecastData: [String: TemperatureForecastResponse] = [:]
    @State private var isLoading = false
    @State private var showToast = false
    @State private var toastMessage = ""

    var body: some View {
        ZStack {
            Image("App_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if favoritesManager.favorites.isEmpty {
                    Text("No favorite locations")
                        .foregroundColor(.secondary)
                } else {
                    TabView(selection: $currentPage) {
                        ForEach(Array(favoritesManager.favorites.enumerated()), id: \.element.id) { index, favorite in
                            if let weather = weatherData["\(favorite.city),\(favorite.state)"] {
                                ScrollView {
                                    VStack {
                                        WeatherContentView(
                                            weather: weather,
                                            forecast15Day: forecastData["\(favorite.city),\(favorite.state)"],
                                            favoritesManager: favoritesManager,
                                            showToast: $showToast,
                                            toastMessage: $toastMessage
                                        )
                                        
                                        if let forecast = forecastData["\(favorite.city),\(favorite.state)"] {
                                            ForecastView(
                                                forecast: forecast,
                                                dailyForecast: weather
                                            )
                                            .padding(.bottom, 100) // Add padding at bottom for better scrolling
                                        }
                                    }
                                }
                                .tag(index)
                            } else {
                                ProgressView()
                                    .tag(index)
                                    .onAppear {
                                        Task {
                                            await loadWeatherData(for: favorite)
                                        }
                                    }
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }
            .onAppear {
                loadAllWeatherData()
            }
            .onChange(of: showToast) { oldValue, newValue in
                if newValue {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        window.makeToast(toastMessage, duration: 2.0, position: .bottom)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                        showToast = false
                    }
                }
            }
        }
    }

    private func loadAllWeatherData() {
        Task {
            for favorite in favoritesManager.favorites {
                await loadWeatherData(for: favorite)
            }
        }
    }

    private func loadWeatherData(for favorite: Favorite) async {
        do {
            let coordinates = try await autocompleteManager.getCoordinates(
                city: favorite.city,
                state: favorite.state
            )

            async let weatherTask = weatherManager.getDailyForecast(
                latitude: coordinates.lat,
                longitude: coordinates.lon
            )
            async let forecastTask = weatherManager.get15DayForecast(
                latitude: coordinates.lat,
                longitude: coordinates.lon
            )
            
            let (weather, forecast) = try await (weatherTask, forecastTask)

            await MainActor.run {
                let key = "\(favorite.city),\(favorite.state)"
                weatherData[key] = weather
                forecastData[key] = forecast
            }
        } catch {
            print("Error loading weather for favorite: \(error)")
        }
    }
}
