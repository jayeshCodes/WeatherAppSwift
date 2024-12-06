//
//  FavoritesManager.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: [FavoriteLocation] = []
    private let favoritesKey = "savedFavorites"
    
    init() {
        loadFavorites()
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            if let decoded = try? JSONDecoder().decode([FavoriteLocation].self, from: data) {
                favorites = decoded
            }
        }
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    func addFavorite(city: String, state: String, lat: String, lon: String) {
        // Check if location already exists
        if !favorites.contains(where: { $0.city == city && $0.state == state }) {
            let favorite = FavoriteLocation(city: city, state: state, lat: lat, lon: lon)
            favorites.append(favorite)
            saveFavorites()
        }
    }
    
    func removeFavorite(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
        saveFavorites()
    }
    
    func removeFavorite(for city: String, state: String) {
        favorites.removeAll { $0.city == city && $0.state == state }
        saveFavorites()
    }
    
    func isFavorite(city: String, state: String) -> Bool {
        return favorites.contains { $0.city == city && $0.state == state }
    }
}
