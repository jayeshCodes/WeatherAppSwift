//
//  AutocompleteModels.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import Foundation

struct AutocompleteResponse: Codable {
    let predictions: [Prediction]
    let status: String
}

struct Prediction: Codable, Identifiable {
    let description: String
    let placeId: String
    let structuredFormatting: StructuredFormatting
    
    // Computed property for Identifiable conformance
    var id: String { placeId }
    
    enum CodingKeys: String, CodingKey {
        case description
        case placeId = "place_id"
        case structuredFormatting = "structured_formatting"
    }
}

struct StructuredFormatting: Codable {
    let mainText: String
    let secondaryText: String
    
    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case secondaryText = "secondary_text"
    }
}

// Add Coordinates response structure
struct GeocodeResponse: Codable {
    let results: [GeocodeResult]
    let status: String
}

struct GeocodeResult: Codable {
    let geometry: Geometry
}

struct Geometry: Codable {
    let location: GeoLocation
}

struct GeoLocation: Codable {
    let lat: Double
    let lng: Double
}

// Update existing Coordinates struct to match our internal format
struct Coordinates: Codable {
    let lat: Double
    let lon: Double
    
    init(location: GeoLocation) {
        self.lat = location.lat
        self.lon = location.lng  // Convert lng to lon
    }
}

struct CoordinatesResponse: Codable {
    let status: String
    let data: Coordinates
}

// MARK: - Error Type
enum AutocompleteError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError(Error)
}
