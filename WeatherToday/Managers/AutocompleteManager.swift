//
//  AutocompleteManager.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class AutocompleteManager {
    private let baseUrl = "https://weatherapp-571-xyz.ue.r.appspot.com"

    func getAutocompleteSuggestions(input: String) async throws -> [Prediction] {
        let parameters = ["input": input]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(baseUrl)/api/geocode/autocomplete",
                      method: .get,
                      parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            
                            // Parse predictions array
                            var predictions: [Prediction] = []
                            for predictionJson in json["predictions"].arrayValue {
                                let structuredFormatting = StructuredFormatting(
                                    mainText: predictionJson["structured_formatting"]["main_text"].stringValue,
                                    secondaryText: predictionJson["structured_formatting"]["secondary_text"].stringValue
                                )
                                
                                let prediction = Prediction(
                                    description: predictionJson["description"].stringValue,
                                    placeId: predictionJson["place_id"].stringValue,
                                    structuredFormatting: structuredFormatting
                                )
                                predictions.append(prediction)
                            }
                            
                            continuation.resume(returning: predictions)
                        } catch {
                            continuation.resume(throwing: AutocompleteError.invalidData)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: AutocompleteError.networkError(error))
                    }
                }
        }
    }

    func getCoordinates(street: String = "", city: String, state: String) async throws -> Coordinates {
        let parameters = [
            "street": street,
            "city": city,
            "state": state
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(baseUrl)/api/geocode/coordinates",
                      method: .get,
                      parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            
                            guard let firstResult = json["results"].array?.first else {
                                continuation.resume(throwing: AutocompleteError.invalidData)
                                return
                            }
                            
                            let location = GeoLocation(
                                lat: firstResult["geometry"]["location"]["lat"].doubleValue,
                                lng: firstResult["geometry"]["location"]["lng"].doubleValue
                            )
                            
                            let coordinates = Coordinates(location: location)
                            continuation.resume(returning: coordinates)
                        } catch {
                            continuation.resume(throwing: AutocompleteError.invalidData)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: AutocompleteError.networkError(error))
                    }
                }
        }
    }

    // Helper method to extract city and state from a prediction
    func extractLocationInfo(from prediction: Prediction) -> (city: String, state: String) {
        let components = prediction.structuredFormatting.secondaryText.components(separatedBy: ", ")
        let state = components.first ?? ""
        return (prediction.structuredFormatting.mainText, state)
    }
}
