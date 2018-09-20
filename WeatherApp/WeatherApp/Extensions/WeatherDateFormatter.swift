//
//  WeatherDateFormatter.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation


class WeatherDateFormatter {
    
    static let dayFormat: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "MMM dd"
        return dt
    }()
    
    static let hourFormat: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dt
    }()
}


