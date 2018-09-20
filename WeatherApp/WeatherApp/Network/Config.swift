//
//  Config.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

struct Config {
    struct WeatherServer {
        static let BaseUrl = "http://api.openweathermap.org"
        static let ApiVersion = "/data/2.5/"
        static let ApiKey = "8cf271dc2e840c7a837795366d97ad4e"
        static let IconEndpoint = "http://openweathermap.org/img/w/"
    }
}
