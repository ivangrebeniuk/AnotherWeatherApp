//
//  CurrentWeatherModel.swift
//  YetAnotherWeather
//
//  Created by Ivan Grebenyuk on 12.06.2024.
//

import Foundation

struct CurrentWeatherModel: Codable {
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
        let localTime: String
        let timeZone: String
    }
    
    struct Wind: Codable {
        let windSpeed: Double
        let windGust: Double
        let windDirection: String
        let windDegree: Int
    }
    
    let temperature: Double
    let location: Location
    let condition: Condition
    let isDay: Bool
    let wind: Wind
    let feelsLike: Double
}
