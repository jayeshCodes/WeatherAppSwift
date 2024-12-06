import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "App_Icon" asset catalog image resource.
    static let appIcon = DeveloperToolsSupport.ImageResource(name: "App_Icon", bundle: resourceBundle)

    /// The "App_background" asset catalog image resource.
    static let appBackground = DeveloperToolsSupport.ImageResource(name: "App_background", bundle: resourceBundle)

    /// The "Clear" asset catalog image resource.
    static let clear = DeveloperToolsSupport.ImageResource(name: "Clear", bundle: resourceBundle)

    /// The "CloudCover" asset catalog image resource.
    static let cloudCover = DeveloperToolsSupport.ImageResource(name: "CloudCover", bundle: resourceBundle)

    /// The "Cloudy" asset catalog image resource.
    static let cloudy = DeveloperToolsSupport.ImageResource(name: "Cloudy", bundle: resourceBundle)

    /// The "Drizzle" asset catalog image resource.
    static let drizzle = DeveloperToolsSupport.ImageResource(name: "Drizzle", bundle: resourceBundle)

    /// The "Flurries" asset catalog image resource.
    static let flurries = DeveloperToolsSupport.ImageResource(name: "Flurries", bundle: resourceBundle)

    /// The "Fog" asset catalog image resource.
    static let fog = DeveloperToolsSupport.ImageResource(name: "Fog", bundle: resourceBundle)

    /// The "Freezing Drizzle" asset catalog image resource.
    static let freezingDrizzle = DeveloperToolsSupport.ImageResource(name: "Freezing Drizzle", bundle: resourceBundle)

    /// The "Freezing Rain" asset catalog image resource.
    static let freezingRain = DeveloperToolsSupport.ImageResource(name: "Freezing Rain", bundle: resourceBundle)

    /// The "Heavy Freezing Rain" asset catalog image resource.
    static let heavyFreezingRain = DeveloperToolsSupport.ImageResource(name: "Heavy Freezing Rain", bundle: resourceBundle)

    /// The "Heavy Ice Pellets" asset catalog image resource.
    static let heavyIcePellets = DeveloperToolsSupport.ImageResource(name: "Heavy Ice Pellets", bundle: resourceBundle)

    /// The "Heavy Rain" asset catalog image resource.
    static let heavyRain = DeveloperToolsSupport.ImageResource(name: "Heavy Rain", bundle: resourceBundle)

    /// The "Heavy Snow" asset catalog image resource.
    static let heavySnow = DeveloperToolsSupport.ImageResource(name: "Heavy Snow", bundle: resourceBundle)

    /// The "Humidity" asset catalog image resource.
    static let humidity = DeveloperToolsSupport.ImageResource(name: "Humidity", bundle: resourceBundle)

    /// The "Ice Pellets" asset catalog image resource.
    static let icePellets = DeveloperToolsSupport.ImageResource(name: "Ice Pellets", bundle: resourceBundle)

    /// The "Light Fog" asset catalog image resource.
    static let lightFog = DeveloperToolsSupport.ImageResource(name: "Light Fog", bundle: resourceBundle)

    /// The "Light Freezing Rain" asset catalog image resource.
    static let lightFreezingRain = DeveloperToolsSupport.ImageResource(name: "Light Freezing Rain", bundle: resourceBundle)

    /// The "Light Ice Pellets" asset catalog image resource.
    static let lightIcePellets = DeveloperToolsSupport.ImageResource(name: "Light Ice Pellets", bundle: resourceBundle)

    /// The "Light Rain" asset catalog image resource.
    static let lightRain = DeveloperToolsSupport.ImageResource(name: "Light Rain", bundle: resourceBundle)

    /// The "Light Snow" asset catalog image resource.
    static let lightSnow = DeveloperToolsSupport.ImageResource(name: "Light Snow", bundle: resourceBundle)

    /// The "Light Wind" asset catalog image resource.
    static let lightWind = DeveloperToolsSupport.ImageResource(name: "Light Wind", bundle: resourceBundle)

    /// The "Mostly Clear" asset catalog image resource.
    static let mostlyClear = DeveloperToolsSupport.ImageResource(name: "Mostly Clear", bundle: resourceBundle)

    /// The "Mostly Cloudy" asset catalog image resource.
    static let mostlyCloudy = DeveloperToolsSupport.ImageResource(name: "Mostly Cloudy", bundle: resourceBundle)

    /// The "Partly Cloudy" asset catalog image resource.
    static let partlyCloudy = DeveloperToolsSupport.ImageResource(name: "Partly Cloudy", bundle: resourceBundle)

    /// The "Powered_by_Tomorrow-Black" asset catalog image resource.
    static let poweredByTomorrowBlack = DeveloperToolsSupport.ImageResource(name: "Powered_by_Tomorrow-Black", bundle: resourceBundle)

    /// The "Precipitation" asset catalog image resource.
    static let precipitation = DeveloperToolsSupport.ImageResource(name: "Precipitation", bundle: resourceBundle)

    /// The "Pressure" asset catalog image resource.
    static let pressure = DeveloperToolsSupport.ImageResource(name: "Pressure", bundle: resourceBundle)

    /// The "Rain" asset catalog image resource.
    static let rain = DeveloperToolsSupport.ImageResource(name: "Rain", bundle: resourceBundle)

    /// The "Snow" asset catalog image resource.
    static let snow = DeveloperToolsSupport.ImageResource(name: "Snow", bundle: resourceBundle)

    /// The "Strong Wind" asset catalog image resource.
    static let strongWind = DeveloperToolsSupport.ImageResource(name: "Strong Wind", bundle: resourceBundle)

    /// The "Temperature" asset catalog image resource.
    static let temperature = DeveloperToolsSupport.ImageResource(name: "Temperature", bundle: resourceBundle)

    /// The "Thunderstorm" asset catalog image resource.
    static let thunderstorm = DeveloperToolsSupport.ImageResource(name: "Thunderstorm", bundle: resourceBundle)

    /// The "Today_Tab" asset catalog image resource.
    static let todayTab = DeveloperToolsSupport.ImageResource(name: "Today_Tab", bundle: resourceBundle)

    /// The "UVIndex" asset catalog image resource.
    static let uvIndex = DeveloperToolsSupport.ImageResource(name: "UVIndex", bundle: resourceBundle)

    /// The "Visibility" asset catalog image resource.
    static let visibility = DeveloperToolsSupport.ImageResource(name: "Visibility", bundle: resourceBundle)

    /// The "Weather_Data_Tab" asset catalog image resource.
    static let weatherDataTab = DeveloperToolsSupport.ImageResource(name: "Weather_Data_Tab", bundle: resourceBundle)

    /// The "Weekly_Tab" asset catalog image resource.
    static let weeklyTab = DeveloperToolsSupport.ImageResource(name: "Weekly_Tab", bundle: resourceBundle)

    /// The "Wind" asset catalog image resource.
    static let wind = DeveloperToolsSupport.ImageResource(name: "Wind", bundle: resourceBundle)

    /// The "WindSpeed" asset catalog image resource.
    static let windSpeed = DeveloperToolsSupport.ImageResource(name: "WindSpeed", bundle: resourceBundle)

    /// The "close-circle" asset catalog image resource.
    static let closeCircle = DeveloperToolsSupport.ImageResource(name: "close-circle", bundle: resourceBundle)

    /// The "plus-circle" asset catalog image resource.
    static let plusCircle = DeveloperToolsSupport.ImageResource(name: "plus-circle", bundle: resourceBundle)

    /// The "sun-rise" asset catalog image resource.
    static let sunRise = DeveloperToolsSupport.ImageResource(name: "sun-rise", bundle: resourceBundle)

    /// The "sun-set" asset catalog image resource.
    static let sunSet = DeveloperToolsSupport.ImageResource(name: "sun-set", bundle: resourceBundle)

    /// The "twitter" asset catalog image resource.
    static let twitter = DeveloperToolsSupport.ImageResource(name: "twitter", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "App_Icon" asset catalog image.
    static var appIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIcon)
#else
        .init()
#endif
    }

    /// The "App_background" asset catalog image.
    static var appBackground: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appBackground)
#else
        .init()
#endif
    }

    /// The "Clear" asset catalog image.
    static var clear: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clear)
#else
        .init()
#endif
    }

    /// The "CloudCover" asset catalog image.
    static var cloudCover: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cloudCover)
#else
        .init()
#endif
    }

    /// The "Cloudy" asset catalog image.
    static var cloudy: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cloudy)
#else
        .init()
#endif
    }

    /// The "Drizzle" asset catalog image.
    static var drizzle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .drizzle)
#else
        .init()
#endif
    }

    /// The "Flurries" asset catalog image.
    static var flurries: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .flurries)
#else
        .init()
#endif
    }

    /// The "Fog" asset catalog image.
    static var fog: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fog)
#else
        .init()
#endif
    }

    /// The "Freezing Drizzle" asset catalog image.
    static var freezingDrizzle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .freezingDrizzle)
#else
        .init()
#endif
    }

    /// The "Freezing Rain" asset catalog image.
    static var freezingRain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .freezingRain)
#else
        .init()
#endif
    }

    /// The "Heavy Freezing Rain" asset catalog image.
    static var heavyFreezingRain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .heavyFreezingRain)
#else
        .init()
#endif
    }

    /// The "Heavy Ice Pellets" asset catalog image.
    static var heavyIcePellets: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .heavyIcePellets)
#else
        .init()
#endif
    }

    /// The "Heavy Rain" asset catalog image.
    static var heavyRain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .heavyRain)
#else
        .init()
#endif
    }

    /// The "Heavy Snow" asset catalog image.
    static var heavySnow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .heavySnow)
#else
        .init()
#endif
    }

    /// The "Humidity" asset catalog image.
    static var humidity: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .humidity)
#else
        .init()
#endif
    }

    /// The "Ice Pellets" asset catalog image.
    static var icePellets: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .icePellets)
#else
        .init()
#endif
    }

    /// The "Light Fog" asset catalog image.
    static var lightFog: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightFog)
#else
        .init()
#endif
    }

    /// The "Light Freezing Rain" asset catalog image.
    static var lightFreezingRain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightFreezingRain)
#else
        .init()
#endif
    }

    /// The "Light Ice Pellets" asset catalog image.
    static var lightIcePellets: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightIcePellets)
#else
        .init()
#endif
    }

    /// The "Light Rain" asset catalog image.
    static var lightRain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightRain)
#else
        .init()
#endif
    }

    /// The "Light Snow" asset catalog image.
    static var lightSnow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightSnow)
#else
        .init()
#endif
    }

    /// The "Light Wind" asset catalog image.
    static var lightWind: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightWind)
#else
        .init()
#endif
    }

    /// The "Mostly Clear" asset catalog image.
    static var mostlyClear: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mostlyClear)
#else
        .init()
#endif
    }

    /// The "Mostly Cloudy" asset catalog image.
    static var mostlyCloudy: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mostlyCloudy)
#else
        .init()
#endif
    }

    /// The "Partly Cloudy" asset catalog image.
    static var partlyCloudy: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .partlyCloudy)
#else
        .init()
#endif
    }

    /// The "Powered_by_Tomorrow-Black" asset catalog image.
    static var poweredByTomorrowBlack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .poweredByTomorrowBlack)
#else
        .init()
#endif
    }

    /// The "Precipitation" asset catalog image.
    static var precipitation: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .precipitation)
#else
        .init()
#endif
    }

    /// The "Pressure" asset catalog image.
    static var pressure: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pressure)
#else
        .init()
#endif
    }

    /// The "Rain" asset catalog image.
    static var rain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .rain)
#else
        .init()
#endif
    }

    /// The "Snow" asset catalog image.
    static var snow: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .snow)
#else
        .init()
#endif
    }

    /// The "Strong Wind" asset catalog image.
    static var strongWind: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .strongWind)
#else
        .init()
#endif
    }

    /// The "Temperature" asset catalog image.
    static var temperature: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .temperature)
#else
        .init()
#endif
    }

    /// The "Thunderstorm" asset catalog image.
    static var thunderstorm: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .thunderstorm)
#else
        .init()
#endif
    }

    /// The "Today_Tab" asset catalog image.
    static var todayTab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .todayTab)
#else
        .init()
#endif
    }

    /// The "UVIndex" asset catalog image.
    static var uvIndex: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .uvIndex)
#else
        .init()
#endif
    }

    /// The "Visibility" asset catalog image.
    static var visibility: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .visibility)
#else
        .init()
#endif
    }

    /// The "Weather_Data_Tab" asset catalog image.
    static var weatherDataTab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .weatherDataTab)
#else
        .init()
#endif
    }

    /// The "Weekly_Tab" asset catalog image.
    static var weeklyTab: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .weeklyTab)
#else
        .init()
#endif
    }

    /// The "Wind" asset catalog image.
    static var wind: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wind)
#else
        .init()
#endif
    }

    /// The "WindSpeed" asset catalog image.
    static var windSpeed: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .windSpeed)
#else
        .init()
#endif
    }

    /// The "close-circle" asset catalog image.
    static var closeCircle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .closeCircle)
#else
        .init()
#endif
    }

    /// The "plus-circle" asset catalog image.
    static var plusCircle: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .plusCircle)
#else
        .init()
#endif
    }

    /// The "sun-rise" asset catalog image.
    static var sunRise: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sunRise)
#else
        .init()
#endif
    }

    /// The "sun-set" asset catalog image.
    static var sunSet: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sunSet)
#else
        .init()
#endif
    }

    /// The "twitter" asset catalog image.
    static var twitter: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .twitter)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "App_Icon" asset catalog image.
    static var appIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIcon)
#else
        .init()
#endif
    }

    /// The "App_background" asset catalog image.
    static var appBackground: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appBackground)
#else
        .init()
#endif
    }

    /// The "Clear" asset catalog image.
    static var clear: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clear)
#else
        .init()
#endif
    }

    /// The "CloudCover" asset catalog image.
    static var cloudCover: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cloudCover)
#else
        .init()
#endif
    }

    /// The "Cloudy" asset catalog image.
    static var cloudy: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cloudy)
#else
        .init()
#endif
    }

    /// The "Drizzle" asset catalog image.
    static var drizzle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .drizzle)
#else
        .init()
#endif
    }

    /// The "Flurries" asset catalog image.
    static var flurries: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .flurries)
#else
        .init()
#endif
    }

    /// The "Fog" asset catalog image.
    static var fog: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fog)
#else
        .init()
#endif
    }

    /// The "Freezing Drizzle" asset catalog image.
    static var freezingDrizzle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .freezingDrizzle)
#else
        .init()
#endif
    }

    /// The "Freezing Rain" asset catalog image.
    static var freezingRain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .freezingRain)
#else
        .init()
#endif
    }

    /// The "Heavy Freezing Rain" asset catalog image.
    static var heavyFreezingRain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .heavyFreezingRain)
#else
        .init()
#endif
    }

    /// The "Heavy Ice Pellets" asset catalog image.
    static var heavyIcePellets: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .heavyIcePellets)
#else
        .init()
#endif
    }

    /// The "Heavy Rain" asset catalog image.
    static var heavyRain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .heavyRain)
#else
        .init()
#endif
    }

    /// The "Heavy Snow" asset catalog image.
    static var heavySnow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .heavySnow)
#else
        .init()
#endif
    }

    /// The "Humidity" asset catalog image.
    static var humidity: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .humidity)
#else
        .init()
#endif
    }

    /// The "Ice Pellets" asset catalog image.
    static var icePellets: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .icePellets)
#else
        .init()
#endif
    }

    /// The "Light Fog" asset catalog image.
    static var lightFog: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lightFog)
#else
        .init()
#endif
    }

    /// The "Light Freezing Rain" asset catalog image.
    static var lightFreezingRain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lightFreezingRain)
#else
        .init()
#endif
    }

    /// The "Light Ice Pellets" asset catalog image.
    static var lightIcePellets: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lightIcePellets)
#else
        .init()
#endif
    }

    /// The "Light Rain" asset catalog image.
    static var lightRain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lightRain)
#else
        .init()
#endif
    }

    /// The "Light Snow" asset catalog image.
    static var lightSnow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lightSnow)
#else
        .init()
#endif
    }

    /// The "Light Wind" asset catalog image.
    static var lightWind: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lightWind)
#else
        .init()
#endif
    }

    /// The "Mostly Clear" asset catalog image.
    static var mostlyClear: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mostlyClear)
#else
        .init()
#endif
    }

    /// The "Mostly Cloudy" asset catalog image.
    static var mostlyCloudy: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mostlyCloudy)
#else
        .init()
#endif
    }

    /// The "Partly Cloudy" asset catalog image.
    static var partlyCloudy: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .partlyCloudy)
#else
        .init()
#endif
    }

    /// The "Powered_by_Tomorrow-Black" asset catalog image.
    static var poweredByTomorrowBlack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .poweredByTomorrowBlack)
#else
        .init()
#endif
    }

    /// The "Precipitation" asset catalog image.
    static var precipitation: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .precipitation)
#else
        .init()
#endif
    }

    /// The "Pressure" asset catalog image.
    static var pressure: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pressure)
#else
        .init()
#endif
    }

    /// The "Rain" asset catalog image.
    static var rain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .rain)
#else
        .init()
#endif
    }

    /// The "Snow" asset catalog image.
    static var snow: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .snow)
#else
        .init()
#endif
    }

    /// The "Strong Wind" asset catalog image.
    static var strongWind: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .strongWind)
#else
        .init()
#endif
    }

    /// The "Temperature" asset catalog image.
    static var temperature: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .temperature)
#else
        .init()
#endif
    }

    /// The "Thunderstorm" asset catalog image.
    static var thunderstorm: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .thunderstorm)
#else
        .init()
#endif
    }

    /// The "Today_Tab" asset catalog image.
    static var todayTab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .todayTab)
#else
        .init()
#endif
    }

    /// The "UVIndex" asset catalog image.
    static var uvIndex: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .uvIndex)
#else
        .init()
#endif
    }

    /// The "Visibility" asset catalog image.
    static var visibility: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .visibility)
#else
        .init()
#endif
    }

    /// The "Weather_Data_Tab" asset catalog image.
    static var weatherDataTab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .weatherDataTab)
#else
        .init()
#endif
    }

    /// The "Weekly_Tab" asset catalog image.
    static var weeklyTab: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .weeklyTab)
#else
        .init()
#endif
    }

    /// The "Wind" asset catalog image.
    static var wind: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wind)
#else
        .init()
#endif
    }

    /// The "WindSpeed" asset catalog image.
    static var windSpeed: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .windSpeed)
#else
        .init()
#endif
    }

    /// The "close-circle" asset catalog image.
    static var closeCircle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .closeCircle)
#else
        .init()
#endif
    }

    /// The "plus-circle" asset catalog image.
    static var plusCircle: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .plusCircle)
#else
        .init()
#endif
    }

    /// The "sun-rise" asset catalog image.
    static var sunRise: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sunRise)
#else
        .init()
#endif
    }

    /// The "sun-set" asset catalog image.
    static var sunSet: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sunSet)
#else
        .init()
#endif
    }

    /// The "twitter" asset catalog image.
    static var twitter: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .twitter)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

