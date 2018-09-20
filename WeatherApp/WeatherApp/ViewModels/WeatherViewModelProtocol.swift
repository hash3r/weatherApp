//
//  WeatherViewModelProtocol.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

/// Protocol represents result view model.
protocol WeatherViewModelProtocol {

    /// Data source
    var forecast: ForecastModel { get }
    
    /// Progress state
    var isLoading: Bool { get }
    
    /// Current query for requests
    var queryModel: WeatherQueryModel! { get set }
    
    /// Method asks for the next chunk of data
    ///
    /// - Returns: promise with a suggestion to update UI
    func loadData(_ success: @escaping SuccessCompletion<Bool>, _ failure: @escaping FailureCompletion)
}
