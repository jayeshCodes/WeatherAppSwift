//
//  FavoritesModels.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import Foundation

struct FavoriteLocation: Codable, Identifiable {
    let id: UUID
    let city: String
    let state: String
    let lat: String
    let lon: String
    
    init(id: UUID = UUID(), city: String, state: String, lat: String, lon: String) {
        self.id = id
        self.city = city
        self.state = state
        self.lat = lat
        self.lon = lon
    }
}
