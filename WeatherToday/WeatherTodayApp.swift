//
//  WeatherTodayApp.swift
//  WeatherToday
//
//  Created by Jayesh Gajbhar on 12/5/24.
//

import SwiftUI
import SwiftData

@main
struct WeatherTodayApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
