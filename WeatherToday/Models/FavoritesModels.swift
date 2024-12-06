//
//  FavoritesModels.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import Foundation

struct FavoriteResponse: Codable {
    let status: String
    let data: [Favorite]
}

struct Favorite: Codable, Identifiable {
    let id: String
    let city: String
    let state: String
}

struct CheckFavoriteResponse: Codable {
    let isFavorite: Bool
    let favoriteId: String?
}

struct ApiResponse<T: Codable>: Codable {
    let status: String
    let data: T
}
