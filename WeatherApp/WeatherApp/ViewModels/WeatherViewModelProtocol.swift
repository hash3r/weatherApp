//
//  WeatherViewModelProtocol.swift
//  GYGtest
//
//  Created by Hnatiuk, Volodymyr on 25.08.18.
//  Copyright © 2018 GYG. All rights reserved.
//

import Foundation

/// Protocol represents result view model.
protocol WeatherViewModelProtocol {

    /// Data source
    var weatherModel: [WeatherModel] { get }
    
    /// Progress state
    var isLoading: Bool { get }
    
    /// Current query for requests
    var queryModel: WeatherQueryModel! { get set }
    
    /// Method asks for the next chunk of data
    ///
    /// - Returns: promise with a suggestion to update UI
    func loadData() //-> Promise<Bool>
}
