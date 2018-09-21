//
//  TargetType.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

public typealias PathType = String
public typealias ParametersType = [String: Any]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

/// Protocol describes endpoints metadata
public protocol TargetType {
    
    func baseUrl() -> PathType
    func path() -> PathType
    func method() -> HTTPMethod
    func params() -> ParametersType?
    func headers() -> ParametersType
    func stubData() -> Data?
}

/// implement default behaviour
extension TargetType {
    
    func baseUrl() -> PathType {
        return Config.WeatherServer.BaseUrl + Config.WeatherServer.ApiVersion
    }
    
    func params() -> ParametersType? {
        return nil
    }
    
    func headers() -> ParametersType {
        return [:]
    }
    
    func stubData() -> Data? {
        return nil
    }
    
}
