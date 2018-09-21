//
//  WeatherTarget.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

enum WeatherTarget {
    case forecast(query: WeatherQueryModel)
}

extension WeatherTarget: TargetType {
    
    func path() -> PathType {
        switch self {
        case .forecast(let query):
            var path = "forecast?"
            path += "q=\(query.city)"
            path += "&appid=\(Config.WeatherServer.ApiKey)"
            path += "&units=metric"
            return path
        }
    }
    
    func method() -> HTTPMethod {
        switch self {
        case .forecast: return .get
        }
    }
    
    func stubData() -> Data? {
        switch self {
        case .forecast(let query):
            if let stubPath = query.dataSource.path(),
                let path = Bundle.main.path(forResource: stubPath, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    return data
                } catch let error {
                    debugPrint("parse error: \(error.localizedDescription)")
                }
            } else {
                debugPrint("Invalid filename/path.")
            }
        }
        return nil
    }
}
