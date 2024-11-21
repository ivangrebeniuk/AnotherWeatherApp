//
//  ForecastParser.swift
//  YetAnotherWeather
//
//  Created by Ivan Grebenyuk on 24.09.2024.
//

import Foundation
import SwiftyJSON

final class ForecastParser: IJSONParser {
    
    private let dateFormatter: ICustomDateFormatter
    
    init(dateFormatter: ICustomDateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    func parse(_ json: JSON) throws -> ForecastModel {
        let currentWeatherParser = CurrentWeatherParser()
        
        guard let forecastDay = json["forecast"]["forecastday"].array else {
            throw NetworkRequestError.modelParsingError
        }
        
        let days: [ForecastModel.ForecastDay] = try forecastDay.map {
            guard
                let stringDate = $0["date"].string,
                let date = dateFormatter.localDate(from: stringDate),
                let maxTemp = $0["day"]["maxtemp_c"].double,
                let minTemp = $0["day"]["mintemp_c"].double,
                let avgTemp = $0["day"]["avgtemp_c"].double,
                let text = $0["day"]["condition"]["text"].string,
                let icon = $0["day"]["condition"]["icon"].string,
                let iconUrl = URL(string: "https:" + icon),
                let daylyChanceOfRain = $0["day"]["daily_chance_of_rain"].int
            else {
                throw NetworkRequestError.modelParsingError
            }

            return ForecastModel.ForecastDay(
                date: date,
                lowTemp: maxTemp,
                highTemp: minTemp,
                avgTemp: avgTemp,
                condition: .init(text: text, iconUrl: iconUrl),
                daylyChanceOfRain: daylyChanceOfRain
            )
        }
        return ForecastModel(
            currentWeather: try currentWeatherParser.parse(json),
            forecastDays: days
        )
    }
}
