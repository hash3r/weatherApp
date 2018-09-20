//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation


public enum NetworkError: Error {
    case requestError(_ error: String)
    case responseError(_ error: Error)
    case parseError(_ type: String)
    case serverError
    
    func description() -> String {
        switch self {
        case .requestError(let error):
            return error
        case .responseError(let error):
            return error.localizedDescription
        case .parseError(let type):
            return "Unable to parse the response in given type: \(type)"
        case .serverError:
            return "Server error"
        }
    }
}
