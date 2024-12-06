//
//  WeatherView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI
import Toast

struct WeatherView: View {
    let weather: WeatherResponse
    @StateObject private var favoritesManager = FavoritesManager()
    @State private var searchText = ""
    @State private var forecast15Day: TemperatureForecastResponse?
    @State private var predictions: [Prediction] = []
    @State private var isSearching = false
    @State private var showPredictions = false
    @State private var selectedLocationWeather: WeatherResponse?
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var selectedTab = 0
    @State private var favoriteWeatherData: [String: WeatherResponse] = [:]
    let weatherManager = WeatherManager()
    let autocompleteManager = AutocompleteManager()
    
    // Debounce timer for search
    @State private var searchDebounceTimer: Timer?
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Current Location Tab
            currentLocationView
                .tabItem {
                    Label("Current", systemImage: "location.fill")
                }
                .tag(0)
            
            // Favorites Tab
            favoritesView
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag(1)
        }
        .onChange(of: showToast) { oldValue, newValue in
            if newValue {
                // Show toast using Toast-Swift
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.makeToast(toastMessage, duration: 2.0, position: .bottom)
                }
                // Reset toast state after showing
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                    showToast = false
                }
            }
        }
        .task {
            await loadFavoriteWeatherData()
        }
    }
    
    // MARK: - Views
    
    private var currentLocationView: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                // Search Bar
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Enter City Name", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onChange(of: searchText) { oldValue, newValue in
                                searchDebounceTimer?.invalidate()
                                showPredictions = !searchText.isEmpty
                                
                                if !searchText.isEmpty {
                                    searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                        Task {
                                            await fetchPredictions()
                                        }
                                    }
                                } else {
                                    predictions = []
                                }
                            }
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    // Predictions List
                    if showPredictions && !predictions.isEmpty {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(predictions) { prediction in
                                    let (city, state) = autocompleteManager.extractLocationInfo(from: prediction)
                                    Button(action: {
                                        Task {
                                            await handleLocationSelection(city: city, state: state)
                                        }
                                    }) {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(city)
                                                    .foregroundColor(.primary)
                                                Text(state)
                                                    .foregroundColor(.secondary)
                                                    .font(.caption)
                                            }
                                            Spacer()
                                        }
                                        .padding()
                                    }
                                    Divider()
                                }
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(maxHeight: 200)
                    }
                }
                .padding(.horizontal)
                
                // Weather Content
                if !showPredictions {
                    if let selectedWeather = selectedLocationWeather {
                        // Display selected location weather with favorite button
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    toggleFavorite(selectedWeather)
                                }) {
                                    Image(systemName: isFavorite(selectedWeather) ? "xmark" : "plus")
                                        .foregroundColor(.primary)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .clipShape(Circle())
                                }
                                .padding(.trailing)
                            }
                            WeatherContentView(weather: selectedWeather, forecast15Day: forecast15Day)
                        }
                    } else {
                        // Display current location weather
                        WeatherContentView(weather: weather, forecast15Day: forecast15Day)
                    }
                }
                
                Spacer()
            }
        }
        .task {
            do {
                forecast15Day = try await weatherManager.get15DayForecast(
                    latitude: Double(weather.location.lat) ?? 0,
                    longitude: Double(weather.location.lon) ?? 0
                )
            } catch {
                print("Error fetching 15-day forecast: \(error)")
            }
        }
    }
    
    private var favoritesView: some View {
        Group {
            if favoritesManager.favorites.isEmpty {
                Text("No favorite locations")
                    .foregroundColor(.secondary)
            } else {
                TabView {
                    ForEach(favoritesManager.favorites) { favorite in
                        if let weatherData = favoriteWeatherData["\(favorite.city),\(favorite.state)"] {
                            WeatherContentView(
                                weather: weatherData,
                                forecast15Day: nil
                            )
                        } else {
                            ProgressView()
                                .task {
                                    await loadWeatherForFavorite(favorite)
                                }
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchPredictions() async {
        do {
            let newPredictions = try await autocompleteManager.getAutocompleteSuggestions(input: searchText)
            await MainActor.run {
                predictions = newPredictions
            }
        } catch {
            print("Error fetching predictions: \(error)")
            await MainActor.run {
                predictions = []
            }
        }
    }
    
    private func handleLocationSelection(city: String, state: String) async {
        // Clear search and hide predictions
        await MainActor.run {
            searchText = ""
            showPredictions = false
            selectedLocationWeather = nil // Clear previous selection while loading
        }
        
        do {
            // 1. Get coordinates for the selected city
            let coordinates = try await autocompleteManager.getCoordinates(city: city, state: state)
            
            // 2. Fetch weather data using coordinates
            let weatherData = try await weatherManager.getDailyForecast(
                latitude: coordinates.lat,
                longitude: coordinates.lon
            )
            
            // 3. Fetch 15-day forecast
            let newForecast15Day = try await weatherManager.get15DayForecast(
                latitude: coordinates.lat,
                longitude: coordinates.lon
            )
            
            // 4. Update UI with new data
            await MainActor.run {
                selectedLocationWeather = weatherData
                forecast15Day = newForecast15Day
            }
        } catch {
            print("Error fetching weather data: \(error)")
            // Handle error appropriately (show alert, etc.)
        }
    }
    
    private func toggleFavorite(_ weatherData: WeatherResponse) {
        let city = weatherData.location.city
        let state = weatherData.location.state
        
        if isFavorite(weatherData) {
            favoritesManager.removeFavorite(for: city, state: state)
            toastMessage = "\(city) removed from favorites"
        } else {
            favoritesManager.addFavorite(
                city: city,
                state: state,
                lat: weatherData.location.lat,
                lon: weatherData.location.lon
            )
            toastMessage = "\(city) added to favorites"
            Task {
                await loadFavoriteWeatherData()
            }
        }
        
        showToast = true
    }
    
    private func isFavorite(_ weatherData: WeatherResponse) -> Bool {
        favoritesManager.isFavorite(
            city: weatherData.location.city,
            state: weatherData.location.state
        )
    }
    
    private func loadFavoriteWeatherData() async {
        for favorite in favoritesManager.favorites {
            await loadWeatherForFavorite(favorite)
        }
    }
    
    private func loadWeatherForFavorite(_ favorite: FavoriteLocation) async {
        do {
            let weather = try await weatherManager.getDailyForecast(
                latitude: Double(favorite.lat) ?? 0,
                longitude: Double(favorite.lon) ?? 0
            )
            await MainActor.run {
                favoriteWeatherData["\(favorite.city),\(favorite.state)"] = weather
            }
        } catch {
            print("Error loading weather for favorite: \(error)")
        }
    }
}

// Helper Functions
func getWeatherIconName(_ code: Int) -> String {
    switch code {
    case 1000: return "sun.max.fill"
    case 1100: return "cloud.sun.fill"
    case 1101: return "cloud.fill"
    case 1102: return "cloud.fill"
    case 1001: return "cloud.fill"
    default: return "cloud.fill"
    }
}

func getWeatherDescription(_ code: Int) -> String {
    switch code {
    case 1000: return "Clear"
    case 1100: return "Mostly Clear"
    case 1101: return "Partly Cloudy"
    case 1102: return "Mostly Cloudy"
    case 1001: return "Cloudy"
    default: return "Unknown"
    }
}

func formatDate(_ dateString: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

    if let date = formatter.date(from: dateString) {
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    return dateString
}
