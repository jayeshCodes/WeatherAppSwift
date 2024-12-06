//
//  AutocompleteManager.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import Foundation

// MARK: - Autocomplete Manager
class AutocompleteManager {
    private let baseUrl = "https://weatherapp-571-xyz.ue.r.appspot.com"

    func getAutocompleteSuggestions(input: String) async throws -> [Prediction]
    {
        var components = URLComponents(
            string: baseUrl + "/api/geocode/autocomplete")!
        components.queryItems = [
            URLQueryItem(name: "input", value: input)
        ]

        guard let url = components.url else {
            throw AutocompleteError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                throw AutocompleteError.invalidResponse
            }

            do {
                let decodedResponse = try JSONDecoder().decode(
                    AutocompleteResponse.self, from: data)
                return decodedResponse.predictions
            } catch {
                print("Decoding error: \(error)")
                throw AutocompleteError.invalidData
            }
        } catch {
            throw AutocompleteError.networkError(error)
        }
    }

    func getCoordinates(street: String = "", city: String, state: String)
        async throws -> Coordinates
    {
        var components = URLComponents(
            string: baseUrl + "/api/geocode/coordinates")!
        components.queryItems = [
            URLQueryItem(name: "street", value: street),
            URLQueryItem(name: "city", value: city),
            URLQueryItem(name: "state", value: state),
        ]

        guard let url = components.url else {
            throw AutocompleteError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                throw AutocompleteError.invalidResponse
            }

            do {
                let geocodeResponse = try JSONDecoder().decode(
                    GeocodeResponse.self, from: data)

                guard let firstResult = geocodeResponse.results.first else {
                    throw AutocompleteError.invalidData
                }

                // Convert Google's format to our internal Coordinates format
                return Coordinates(location: firstResult.geometry.location)

            } catch {
                print("Decoding error: \(error)")
                throw AutocompleteError.invalidData
            }
        } catch {
            throw AutocompleteError.networkError(error)
        }
    }

    // Helper method to extract city and state from a prediction
    func extractLocationInfo(from prediction: Prediction) -> (
        city: String, state: String
    ) {
        let components = prediction.structuredFormatting.secondaryText
            .components(separatedBy: ", ")
        let state = components.first ?? ""
        return (prediction.structuredFormatting.mainText, state)
    }
}
