//
//  WeatherTarget.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

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
}
