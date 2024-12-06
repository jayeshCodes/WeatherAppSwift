//
//  WeatherManager.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class WeatherManager: ObservableObject {
    private let baseUrl = "https://weatherapp-571-xyz.ue.r.appspot.com"

    // Get daily forecast
    func getDailyForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse {
        let endpoint = "/api/weather/daily"
        let parameters: [String: String] = [
            "lat": String(latitude),
            "lon": String(longitude)
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(baseUrl)\(endpoint)",
                      method: .get,
                      parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            
                            // Check if we have a valid response
                            guard json["status"].string == "success" else {
                                continuation.resume(throwing: WeatherError.invalidResponse)
                                return
                            }
                            
                            let weatherData = json["data"]
                            
                            // Parse location data
                            let location = Location(
                                lat: weatherData["location"]["lat"].stringValue,
                                lon: weatherData["location"]["lon"].stringValue,
                                city: weatherData["location"]["city"].stringValue,
                                state: weatherData["location"]["state"].stringValue
                            )
                            
                            // Parse timelines data
                            var timelines: [Timeline] = []
                            for timelineJson in weatherData["timelines"].arrayValue {
                                let values = timelineJson["values"]
                                let weatherValues = WeatherValues(
                                    temperature: values["temperature"].doubleValue,
                                    temperatureMax: values["temperatureMax"].doubleValue,
                                    temperatureMin: values["temperatureMin"].doubleValue,
                                    humidity: values["humidity"].doubleValue,
                                    windSpeed: values["windSpeed"].doubleValue,
                                    precipitationProbability: values["precipitationProbability"].doubleValue,
                                    weatherCode: values["weatherCode"].intValue
                                )
                                
                                let timeline = Timeline(
                                    time: timelineJson["time"].stringValue,
                                    values: weatherValues
                                )
                                timelines.append(timeline)
                            }
                            
                            let weatherResponse = WeatherResponse(
                                location: location,
                                timelines: timelines
                            )
                            
                            continuation.resume(returning: weatherResponse)
                        } catch {
                            continuation.resume(throwing: WeatherError.invalidData)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: WeatherError.networkError(error))
                    }
                }
        }
    }

    // Get 15-day temperature forecast
    func get15DayForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> TemperatureForecastResponse {
        let endpoint = "/api/weather/temperature"
        let parameters: [String: String] = [
            "lat": String(latitude),
            "lon": String(longitude)
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(baseUrl)\(endpoint)",
                      method: .get,
                      parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            
                            guard json["status"].string == "success" else {
                                continuation.resume(throwing: WeatherError.invalidResponse)
                                return
                            }
                            
                            var timelines: [TemperatureTimeline] = []
                            for timelineJson in json["data"]["timelines"].arrayValue {
                                let values = timelineJson["values"]
                                let temperatureValues = TemperatureValues(
                                    temperatureMax: values["temperatureMax"].doubleValue,
                                    temperatureMin: values["temperatureMin"].doubleValue
                                )
                                
                                let timeline = TemperatureTimeline(
                                    time: timelineJson["time"].stringValue,
                                    values: temperatureValues
                                )
                                timelines.append(timeline)
                            }
                            
                            let forecastResponse = TemperatureForecastResponse(timelines: timelines)
                            continuation.resume(returning: forecastResponse)
                        } catch {
                            continuation.resume(throwing: WeatherError.invalidData)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: WeatherError.networkError(error))
                    }
                }
        }
    }

    // Get all weather data
    func getAllWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse {
        let endpoint = "/api/weather/all"
        let parameters: [String: String] = [
            "lat": String(latitude),
            "lon": String(longitude)
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(baseUrl)\(endpoint)",
                      method: .get,
                      parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            
                            guard json["status"].string == "success" else {
                                continuation.resume(throwing: WeatherError.invalidResponse)
                                return
                            }
                            
                            let weatherData = json["data"]
                            
                            // Parse location data
                            let location = Location(
                                lat: weatherData["location"]["lat"].stringValue,
                                lon: weatherData["location"]["lon"].stringValue,
                                city: weatherData["location"]["city"].stringValue,
                                state: weatherData["location"]["state"].stringValue
                            )
                            
                            // Parse timelines data
                            var timelines: [Timeline] = []
                            for timelineJson in weatherData["timelines"].arrayValue {
                                let values = timelineJson["values"]
                                let weatherValues = WeatherValues(
                                    temperature: values["temperature"].doubleValue,
                                    temperatureMax: values["temperatureMax"].doubleValue,
                                    temperatureMin: values["temperatureMin"].doubleValue,
                                    humidity: values["humidity"].doubleValue,
                                    windSpeed: values["windSpeed"].doubleValue,
                                    precipitationProbability: values["precipitationProbability"].doubleValue,
                                    weatherCode: values["weatherCode"].intValue
                                )
                                
                                let timeline = Timeline(
                                    time: timelineJson["time"].stringValue,
                                    values: weatherValues
                                )
                                timelines.append(timeline)
                            }
                            
                            let weatherResponse = WeatherResponse(
                                location: location,
                                timelines: timelines
                            )
                            
                            continuation.resume(returning: weatherResponse)
                        } catch {
                            continuation.resume(throwing: WeatherError.invalidData)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: WeatherError.networkError(error))
                    }
                }
        }
    }
}
