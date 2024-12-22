//
//  WeatherDetailsAssembly.swift
//  YetAnotherWeather
//
//  Created by Ivan Grebenyuk on 30.07.2024.
//

import Foundation
import UIKit

final class WeatherDetailsAssembly {
    
    // Dependencies
    private let beaufortScaleResolver: IBeaufortScaleResolver
    private let dateFormatter: ICustomDateFormatter
    private let forecastService: IForecastService
    private let feedbackGeneratorService: IFeedbackGeneratorService
    
    // MARK: - Init
    
    init(
        beaufortScaleResolver: IBeaufortScaleResolver,
        dateFormatter: ICustomDateFormatter,
        forecastService: IForecastService,
        feedbackGeneratorService: IFeedbackGeneratorService
    ) {
        self.beaufortScaleResolver = beaufortScaleResolver
        self.dateFormatter = dateFormatter
        self.forecastService = forecastService
        self.feedbackGeneratorService = feedbackGeneratorService
    }
    
    func assemble(location: String, isAddedToFavourites: Bool, output: WeatherDetailsOutput) -> UIViewController {
        
        let viewModelFactory = WeatherDetailsViewModelFactory(
            beaufortScaleResolver: beaufortScaleResolver,
            dateFormatter: dateFormatter
        )
        let alertViewModelFactory = AlertViewModelFactory()
        
        let presenter = WeatherDetailsPresenter(
            alertViewModelFactory: alertViewModelFactory,
            forecastService: forecastService,
            viewModelFactory: viewModelFactory,
            feedbackGenerator: feedbackGeneratorService,
            location: location,
            isAddedToFavourites: isAddedToFavourites,
            output: output
        )
        
        let vc = WeatherDetailsViewController(presenter: presenter)
        presenter.view = vc
        
        return vc
    }
}
