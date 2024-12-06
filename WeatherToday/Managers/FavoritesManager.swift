//
//  FavoritesManager.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/6/24.
//

import Foundation
import Alamofire
import SwiftyJSON

@MainActor
class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: [Favorite] = []
    private let baseUrl = "https://weatherapp-571-xyz.ue.r.appspot.com"
    
    init() {
        Task {
            await loadFavorites()
        }
    }
    
    func loadFavorites() async {
        AF.request("\(baseUrl)/api/favorites").responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    let favoritesArray = json["data"].arrayValue.map { favoriteJson in
                        Favorite(
                            id: favoriteJson["id"].stringValue,
                            city: favoriteJson["city"].stringValue,
                            state: favoriteJson["state"].stringValue
                        )
                    }
                    
                    Task { @MainActor in
                        self?.favorites = favoritesArray
                    }
                } catch {
                    print("Error parsing favorites: \(error)")
                }
            case .failure(let error):
                print("Error loading favorites: \(error)")
            }
        }
    }
    
    func addFavorite(city: String, state: String) async -> Bool {
        return await withCheckedContinuation { continuation in
            let parameters: Parameters = [
                "city": city,
                "state": state
            ]
            
            AF.request("\(baseUrl)/api/favorites",
                      method: .post,
                      parameters: parameters,
                      encoding: JSONEncoding.default)
                .responseData { [weak self] response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            if json["status"].stringValue == "success" {
                                Task {
                                    await self?.loadFavorites()
                                }
                                continuation.resume(returning: true)
                            } else {
                                continuation.resume(returning: false)
                            }
                        } catch {
                            continuation.resume(returning: false)
                        }
                    case .failure:
                        continuation.resume(returning: false)
                    }
                }
        }
    }
    
    func removeFavorite(id: String) async -> Bool {
        return await withCheckedContinuation { continuation in
            AF.request("\(baseUrl)/api/favorites/\(id)",
                      method: .delete)
                .responseData { [weak self] response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            if json["status"].stringValue == "success" {
                                Task {
                                    await self?.loadFavorites()
                                }
                                continuation.resume(returning: true)
                            } else {
                                continuation.resume(returning: false)
                            }
                        } catch {
                            continuation.resume(returning: false)
                        }
                    case .failure:
                        continuation.resume(returning: false)
                    }
                }
        }
    }
    
    func checkFavorite(city: String, state: String) async -> Bool {
        return await withCheckedContinuation { continuation in
            let parameters: [String: String] = [
                "city": city,
                "state": state
            ]
            
            AF.request("\(baseUrl)/api/favorites/check",
                      method: .get,
                      parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let json = try JSON(data: data)
                            let isFavorite = json["data"]["isFavorite"].boolValue
                            continuation.resume(returning: isFavorite)
                        } catch {
                            continuation.resume(returning: false)
                        }
                    case .failure:
                        continuation.resume(returning: false)
                    }
                }
        }
    }
}
