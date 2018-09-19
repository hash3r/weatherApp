//
//  WeatherViewControllerDelegate.swift
//  GYGtest
//
//  Created by Hnatiuk, Volodymyr on 7/22/18.
//  Copyright © 2018 GYG. All rights reserved.
//

import Foundation

/// Protocol represents the result controller delegate.
protocol WeatherViewControllerDelegate: class {
    
    /// Called in case of successful data loading
    ///
    /// - Parameter controller: the controller notifying about result
    func didLoadData(_ controller: WeatherViewControllerProtocol)
    
    /// Called in case of failure
    ///
    /// - Parameters:
    /// - Parameter controller: the controller notifying about result
    ///   - error: reason to fail
    func didFailToLoadData(_ controller: WeatherViewControllerProtocol, error: Error)
}
