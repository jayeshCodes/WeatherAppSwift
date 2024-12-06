//
//  ResponseData.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import Foundation

// Weather Response Models
struct WeatherResponse: Codable {
    let location: Location
    let timelines: [Timeline]
}

struct Location: Codable {
    let lat: String
    let lon: String
    let city: String
    let state: String
}

struct Timeline: Codable {
    let time: String
    let values: WeatherValues
}

struct WeatherValues: Codable {
    let temperature: Double
    let temperatureMax: Double
    let temperatureMin: Double
    let humidity: Double
    let windSpeed: Double
    let precipitationProbability: Double
    let weatherCode: Int
    let sunriseTime: String
    let sunsetTime: String
    let visibility: Double
    let pressure: Double
}

// Temperature Forecast Models
struct TemperatureForecastResponse: Codable {
    let timelines: [TemperatureTimeline]
}

struct TemperatureTimeline: Codable {
    let time: String
    let values: TemperatureValues
}

struct TemperatureValues: Codable {
    let temperatureMax: Double
    let temperatureMin: Double
}

// Weather Manager Error Types
enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case networkError(Error)
}
