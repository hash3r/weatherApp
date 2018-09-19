//
//  WeatherViewControllerProtocol.swift
//  GYGtest
//
//  Created by Hnatiuk, Volodymyr on 25.08.18.
//  Copyright © 2018 GYG. All rights reserved.
//

import Foundation

/// Protocol represents the result controller object.
protocol WeatherViewControllerProtocol: class {
    
    /// Delegate for callbacks
    var delegate: WeatherViewControllerDelegate? { get set }
    
    /// Method for loading data sequentially
    ///
    /// - Parameter initial: whether is first call or not
    func loadData(initial: Bool)
}
