//
//  StringExt.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

extension String {
    
    func encodeURLQuery() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US_POSIX")
        return numberFormatter.number(from: self)?.doubleValue
    }
}
