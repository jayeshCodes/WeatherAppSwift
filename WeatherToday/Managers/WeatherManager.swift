//
//  WeatherManager.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import CoreLocation
import Foundation

class WeatherManager: ObservableObject {
    private let baseUrl = "https://weatherapp-571-xyz.ue.r.appspot.com"

    // Get daily forecast
    func getDailyForecast(
        latitude: CLLocationDegrees, longitude: CLLocationDegrees
    ) async throws -> WeatherResponse {
        let endpoint = "/api/weather/daily"
        let params = [
            "lat": String(latitude),
            "lon": String(longitude),
        ]
        return try await fetchWeatherData(endpoint: endpoint, params: params)
    }

    // Get hourly forecast
    func getHourlyForecast(
        latitude: CLLocationDegrees, longitude: CLLocationDegrees
    ) async throws -> WeatherResponse {
        let endpoint = "/api/weather/hourly"
        let params = [
            "lat": String(latitude),
            "lon": String(longitude),
        ]
        return try await fetchWeatherData(endpoint: endpoint, params: params)
    }

    // Get 15-day temperature forecast
    func get15DayForecast(
        latitude: CLLocationDegrees, longitude: CLLocationDegrees
    ) async throws -> TemperatureForecastResponse {
        let endpoint = "/api/weather/temperature"
        let params = [
            "lat": String(latitude),
            "lon": String(longitude),
        ]
        return try await fetchWeatherData(endpoint: endpoint, params: params)
    }

    // Get all weather data
    func getAllWeatherData(
        latitude: CLLocationDegrees, longitude: CLLocationDegrees
    ) async throws -> WeatherResponse {
        let endpoint = "/api/weather/all"
        let params = [
            "lat": String(latitude),
            "lon": String(longitude),
        ]
        return try await fetchWeatherData(endpoint: endpoint, params: params)
    }

    // Generic fetch method
    private func fetchWeatherData<T: Decodable>(
        endpoint: String, params: [String: String]
    ) async throws -> T {
        var components = URLComponents(string: baseUrl + endpoint)!
        components.queryItems = params.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        guard let url = components.url else {
            throw WeatherError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                throw WeatherError.invalidResponse
            }

            //            // Add debug printing
            //            if let jsonString = String(data: data, encoding: .utf8) {
            //                print("Raw JSON response: \(jsonString)")
            //            }

            do {
                let decodedResponse = try JSONDecoder().decode(
                    APIResponse<T>.self, from: data)
                return decodedResponse.data
            } catch {
                print("Decoding error: \(error)")
                throw WeatherError.invalidData
            }
        } catch {
            throw WeatherError.networkError(error)
        }
    }
}

// Supporting types
struct APIResponse<T: Decodable>: Decodable {
    let status: String
    let data: T
}
