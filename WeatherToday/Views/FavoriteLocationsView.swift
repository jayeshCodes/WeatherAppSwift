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
    @State private var currentPage = 0
    @State private var weatherData: [String: WeatherResponse] = [:]
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if favoritesManager.favorites.isEmpty {
                // Show when no favorites
                Text("No favorite locations")
                    .foregroundColor(.secondary)
            } else {
                // TabView for horizontal paging
                TabView(selection: $currentPage) {
                    ForEach(Array(favoritesManager.favorites.enumerated()), id: \.element.id) { index, favorite in
                        if let weather = weatherData["\(favorite.city),\(favorite.state)"] {
                            WeatherContentView(weather: weather, forecast15Day: nil)
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
    }
    
    private func loadAllWeatherData() {
        Task {
            for favorite in favoritesManager.favorites {
                await loadWeatherData(for: favorite)
            }
        }
    }
    
    private func loadWeatherData(for favorite: FavoriteLocation) async {
        do {
            let weather = try await weatherManager.getDailyForecast(
                latitude: Double(favorite.lat) ?? 0,
                longitude: Double(favorite.lon) ?? 0
            )
            await MainActor.run {
                weatherData["\(favorite.city),\(favorite.state)"] = weather
            }
        } catch {
            print("Error loading weather for favorite: \(error)")
        }
    }
}
