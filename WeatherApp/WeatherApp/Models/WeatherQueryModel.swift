//
//  WeatherQueryModel.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

enum DataSourceType: Int {
    case live = 0
    case stub = 1
    
    func path() -> String? {
        switch self {
        case .stub:
            return "WeatherData"
        default:
            return nil
        }
    }
    
    func city() -> String? {
        switch self {
        case .stub:
            return "Munich"
        default:
            return nil
        }
    }
}

class WeatherQueryModel {
    var city: String = ""
    var dataSource = DataSourceType.live
}
