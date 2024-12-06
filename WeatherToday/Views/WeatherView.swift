//
//  WeatherView.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftSpinner
import SwiftUI
import Toast

extension View {
    func showErrorToast(_ message: String) {
        if let windowScene = UIApplication.shared.connectedScenes.first
            as? UIWindowScene,
            let window = windowScene.windows.first
        {
            window.makeToast(message, duration: 2.0, position: .bottom)
        }
    }
}

// Add UISearchBar wrapper
struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var onTextChange: (String) -> Void

    class Coordinator: NSObject, UISearchBarDelegate {
        let parent: SearchBar

        init(_ parent: SearchBar) {
            self.parent = parent
        }

        func searchBar(
            _ searchBar: UISearchBar, textDidChange searchText: String
        ) {
            parent.text = searchText
            parent.onTextChange(searchText)
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Enter City Name"
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

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
    @State private var isLoading = false
    @State private var showingWeatherDetails = false
    let weatherManager = WeatherManager()
    let autocompleteManager = AutocompleteManager()

    // Debounce timer for search
    @State private var searchDebounceTimer: Timer?

    var body: some View {
        ZStack {
            // Background Image Layer
                    Image("App_background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(isLoading ? 0.5 : 1)
            TabView(selection: $selectedTab) {
                currentLocationView
                    .tabItem {
                        Label("Current", systemImage: "location.fill")
                    }
                    .tag(0)

                favoritesView
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    .tag(1)
            }
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = .clear
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            .sheet(isPresented: $showingWeatherDetails) {
                if let selectedWeather = selectedLocationWeather {
                    WeatherDetailsView(
                        weather: selectedWeather,
                        forecast15Day: forecast15Day,
                        favoritesManager: favoritesManager,
                        showToast: $showToast,
                        toastMessage: $toastMessage
                    )
                }
            }
            .onChange(of: showToast) { oldValue, newValue in
                if newValue {
                    if let windowScene = UIApplication.shared.connectedScenes
                        .first as? UIWindowScene,
                        let window = windowScene.windows.first
                    {
                        window.makeToast(
                            toastMessage, duration: 2.0, position: .bottom)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                        showToast = false
                    }
                }
            }
            .task {
                await loadFavoriteWeatherData()
            }
        }
    }

    private var currentLocationView: some View {
        ZStack(alignment: .top) {
            // Background Image Layer
                    Image("App_background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                // Search Bar implementation
                Spacer().frame(height: 15)
                VStack {
                    SearchBar(text: $searchText) { newText in
                        searchDebounceTimer?.invalidate()
                        showPredictions = !newText.isEmpty

                        if !newText.isEmpty {
                            searchDebounceTimer = Timer.scheduledTimer(
                                withTimeInterval: 0.5, repeats: false
                            ) { _ in
                                Task {
                                    await fetchPredictions()
                                }
                            }
                        } else {
                            predictions = []
                        }
                    }
                    .frame(height: 44)

                    // Predictions List
                    if showPredictions && !predictions.isEmpty {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(predictions) { prediction in
                                    let (city, state) =
                                        autocompleteManager.extractLocationInfo(
                                            from: prediction)
                                    Button(action: {
                                        Task {
                                            await handleLocationSelection(
                                                city: city, state: state)
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
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(maxHeight: 200)
                    }
                }
                .padding(.horizontal)

                // Weather Content
                if !showPredictions {
                    WeatherContentView(
                        weather: weather,
                        forecast15Day: forecast15Day,
                        favoritesManager: favoritesManager,
                        showToast: $showToast,
                        toastMessage: $toastMessage
                    )
                    .onTapGesture {
                        selectedLocationWeather = weather
                        showingWeatherDetails = true
                    }
                }

                Spacer()
            }
        }
        .task {
            SwiftSpinner.show("Loading forecast...")
            do {
                forecast15Day = try await weatherManager.get15DayForecast(
                    latitude: Double(weather.location.lat) ?? 0,
                    longitude: Double(weather.location.lon) ?? 0
                )
            } catch {
                print("Error fetching 15-day forecast: \(error)")
                showErrorToast("Failed to fetch forecast data")
            }
            SwiftSpinner.hide()
        }
    }

    private var favoritesView: some View {
        ZStack{
            // Background Image Layer
                    Image("App_background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
            Group {
                if favoritesManager.favorites.isEmpty {
                    Text("No favorite locations")
                        .foregroundColor(.secondary)
                } else {
                    TabView {
                        ForEach(favoritesManager.favorites) { favorite in
                            if let weatherData = favoriteWeatherData[
                                "\(favorite.city),\(favorite.state)"]
                            {
                                WeatherContentView(
                                    weather: weatherData,
                                    forecast15Day: nil,
                                    favoritesManager: favoritesManager,
                                    showToast: $showToast,
                                    toastMessage: $toastMessage
                                )
                                .onTapGesture {
                                    selectedLocationWeather = weatherData
                                    showingWeatherDetails = true
                                }
                            } else {
                                Color.clear
                                    .task {
                                        SwiftSpinner.show("Loading weather data...")
                                        let _ = await loadWeatherForFavorite(
                                            favorite)
                                        SwiftSpinner.hide()
                                    }
                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                }
            }
        }
    }

    // MARK: - Private Methods

    private func fetchPredictions() async {
        SwiftSpinner.show("Searching...")
        do {
            let newPredictions =
                try await autocompleteManager.getAutocompleteSuggestions(
                    input: searchText)
            await MainActor.run {
                predictions = newPredictions
            }
        } catch {
            print("Error fetching predictions: \(error)")
            await MainActor.run {
                predictions = []
                showErrorToast("Failed to fetch location suggestions")
            }
        }
        SwiftSpinner.hide()
    }

    private func handleLocationSelection(city: String, state: String) async {
        await MainActor.run {
            searchText = ""
            showPredictions = false
        }

        SwiftSpinner.show("Fetching weather for \(city)...")

        do {
            let coordinates = try await autocompleteManager.getCoordinates(
                city: city, state: state)
            let weatherData = try await weatherManager.getDailyForecast(
                latitude: coordinates.lat,
                longitude: coordinates.lon
            )
            let newForecast15Day = try await weatherManager.get15DayForecast(
                latitude: coordinates.lat,
                longitude: coordinates.lon
            )

            await MainActor.run {
                selectedLocationWeather = weatherData
                forecast15Day = newForecast15Day
                showingWeatherDetails = true
            }
        } catch {
            print("Error fetching weather data: \(error)")
            await MainActor.run {
                showErrorToast("Failed to fetch weather data for \(city)")
            }
        }

        SwiftSpinner.hide()
    }

    private func loadFavoriteWeatherData() async {
        SwiftSpinner.show("Loading favorites...")
        var hasError = false
        for favorite in favoritesManager.favorites {
            if await !loadWeatherForFavorite(favorite) {
                hasError = true
            }
        }
        if hasError {
            await MainActor.run {
                showErrorToast("Failed to load some favorite locations")
            }
        }
        SwiftSpinner.hide()
    }

    private func loadWeatherForFavorite(_ favorite: Favorite) async -> Bool {
        do {
            let coordinates = try await autocompleteManager.getCoordinates(
                city: favorite.city,
                state: favorite.state
            )

            let weather = try await weatherManager.getDailyForecast(
                latitude: coordinates.lat,
                longitude: coordinates.lon
            )

            await MainActor.run {
                favoriteWeatherData["\(favorite.city),\(favorite.state)"] =
                    weather
            }
            return true
        } catch {
            print("Error loading weather for favorite: \(error)")
            await MainActor.run {
                showErrorToast("Failed to load weather for \(favorite.city)")
            }
            return false
        }
    }
}

func getWeatherIconName(_ code: Int) -> String {
    switch code {
    case 1000: return "sun.max.fill"  // Clear
    case 1001: return "cloud.fill"  // Cloudy
    case 1100: return "cloud.sun.fill"  // Mostly Clear
    case 1101: return "cloud.sun.fill"  // Partly Cloudy
    case 1102: return "cloud.fill"  // Mostly Cloudy
    case 2000: return "cloud.fog.fill"  // Fog
    case 2100: return "cloud.fog.fill"  // Light Fog
    case 4000: return "cloud.drizzle.fill"  // Drizzle
    case 4001: return "cloud.rain.fill"  // Rain
    case 4200: return "cloud.rain.fill"  // Light Rain
    case 4201: return "cloud.heavyrain.fill"  // Heavy Rain
    case 5000: return "cloud.snow.fill"  // Snow
    case 5001: return "cloud.snow.fill"  // Flurries
    case 5100: return "cloud.snow.fill"  // Light Snow
    case 5101: return "cloud.snow.fill"  // Heavy Snow
    case 6000: return "cloud.sleet.fill"  // Freezing Drizzle
    case 6001: return "cloud.sleet.fill"  // Freezing Rain
    case 6200: return "cloud.sleet.fill"  // Light Freezing Rain
    case 6201: return "cloud.sleet.fill"  // Heavy Freezing Rain
    case 7000: return "cloud.hail.fill"  // Ice Pellets
    case 7101: return "cloud.hail.fill"  // Heavy Ice Pellets
    case 7102: return "cloud.hail.fill"  // Light Ice Pellets
    case 8000: return "cloud.bolt.rain.fill"  // Thunderstorm
    default: return "cloud.fill"  // Unknown
    }
}

func getWeatherDescription(_ code: Int) -> String {
    switch code {
    case 1000: return "Clear"
    case 1001: return "Cloudy"
    case 1100: return "Mostly Clear"
    case 1101: return "Partly Cloudy"
    case 1102: return "Mostly Cloudy"
    case 2000: return "Fog"
    case 2100: return "Light Fog"
    case 4000: return "Drizzle"
    case 4001: return "Rain"
    case 4200: return "Light Rain"
    case 4201: return "Heavy Rain"
    case 5000: return "Snow"
    case 5001: return "Flurries"
    case 5100: return "Light Snow"
    case 5101: return "Heavy Snow"
    case 6000: return "Freezing Drizzle"
    case 6001: return "Freezing Rain"
    case 6200: return "Light Freezing Rain"
    case 6201: return "Heavy Freezing Rain"
    case 7000: return "Ice Pellets"
    case 7101: return "Heavy Ice Pellets"
    case 7102: return "Light Ice Pellets"
    case 8000: return "Thunderstorm"
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

#Preview {
    let mockWeather = WeatherResponse(
        location: Location(
            lat: "37.7749",
            lon: "-122.4194",
            city: "San Francisco",
            state: "California"
        ),
        timelines: [
            Timeline(
                time: "2024-12-06T00:00:00Z",
                values: WeatherValues(
                    temperature: 65.0,
                    temperatureMax: 72.0,
                    temperatureMin: 58.0,
                    humidity: 75.0,
                    windSpeed: 8.5,
                    precipitationProbability: 20.0,
                    weatherCode: 1000,
                    sunriseTime: "2024-12-06T06:45:00Z",
                    sunsetTime: "2024-12-06T17:45:00Z",
                    visibility: 10.0,
                    pressure: 29.92,
                    cloudCover: 25.0,
                    uvIndex: 5.0
                )
            )
        ]
    )

    return WeatherView(weather: mockWeather)
        
        .preferredColorScheme(.light)
}

// Preview in dark mode
#Preview {
    let mockWeather = WeatherResponse(
        location: Location(
            lat: "37.7749",
            lon: "-122.4194",
            city: "San Francisco",
            state: "California"
        ),
        timelines: [
            Timeline(
                time: "2024-12-06T00:00:00Z",
                values: WeatherValues(
                    temperature: 65.0,
                    temperatureMax: 72.0,
                    temperatureMin: 58.0,
                    humidity: 75.0,
                    windSpeed: 8.5,
                    precipitationProbability: 20.0,
                    weatherCode: 1000,
                    sunriseTime: "2024-12-06T06:45:00Z",
                    sunsetTime: "2024-12-06T17:45:00Z",
                    visibility: 10.0,
                    pressure: 29.92,
                    cloudCover: 25.0,
                    uvIndex: 5.0
                )
            )
        ]
    )

    return WeatherView(weather: mockWeather)
        
        .preferredColorScheme(.dark)
}
