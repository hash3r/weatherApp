//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    let date: Date
    let hour: Int
    let day: Int
    let temp: Int
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case temp = "temp"
        case icon = "icon"
        case weatherContainer = "weather"
        case tempsContainer = "main"
    }
    
    struct WeatherDetails: Decodable {
        let main: String
        let icon: String
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let date = try container.decode(String.self, forKey: .date)
        self.date = WeatherDateFormatter.hourFormat.date(from: date) ?? Date()
        self.day = Calendar.current.component(.day, from: self.date)
        self.hour = Calendar.current.component(.hour, from: self.date)
        
        let weatherDetails = try container.decode([WeatherDetails].self, forKey: .weatherContainer)
        let details = weatherDetails.first
        if let icon = details?.icon {
            self.icon = "\(Config.WeatherServer.IconEndpoint)\(icon).png"
        } else {
            self.icon = ""
        }
        
        let tempsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tempsContainer)
        self.temp = Int(try tempsContainer.decode(Double.self, forKey: .temp))
    }
    
}
