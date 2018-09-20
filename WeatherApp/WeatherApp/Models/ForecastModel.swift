//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation


struct ForecastModel: Decodable {
    let days: [[WeatherModel]]
    
    init() {
        days = [[WeatherModel]]()
    }
    
    enum CodingKeys: String, CodingKey {
        case days = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let list = try container.decode([WeatherModel].self, forKey: .days)
        let groups = Dictionary(grouping: list, by: { $0.day }).values
        
        //sort by days
        let days = groups.sorted(by: { $0.first!.date < $1.first!.date })
        
        //sort by hours
        self.days = days.map { day in
            return day.sorted(by: { $0.hour <  $1.hour })
        }
    }
}

