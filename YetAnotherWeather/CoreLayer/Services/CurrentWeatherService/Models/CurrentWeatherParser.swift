//
//  CurrentWeatherParser.swift
//  YetAnotherWeather
//
//  Created by Ivan Grebenyuk on 30.06.2024.
//

import Foundation
import SwiftyJSON

final class CurrentWeatherParser: IJSONParser {
    
    // MARK: - IJSONParser
    
    func parse(_ json: JSON) throws -> CurrentWeatherModel {
        
        guard let name = json["location"]["name"].string,
              let region = json["location"]["region"].string,
              let country = json["location"]["country"].string,
              let localTimeString = json["location"]["localtime"].string,
              let timeZone = json["location"]["tz_id"].string,
              let temperature = json["current"]["temp_c"].double,
              let icon = json["current"]["condition"]["icon"].string,
              let iconUrl = URL(string: icon),
              let text = json["current"]["condition"]["text"].string,
              let isDay = json["current"]["is_day"].int
        else { throw NetworkRequestError.modelParsingError }
        
        return CurrentWeatherModel(
            temperature: temperature,
            location: .init(
                name: name,
                region: region,
                country: country,
                localTime: localTimeString,
                timeZone: timeZone
            ),
            condition: .init(text: text, iconUrl: iconUrl),
            isDay: isDay == 1
        )
    }
}
