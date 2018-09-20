//
//  HourWeatherCell.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation
import UIKit

class HourWeatherCell: UICollectionViewCell {
    
    static let Key = "HourWeatherCell"
    
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    
    var hourForecast: WeatherModel? {
        didSet {
            guard let _ = hourForecast else { return }
            self.configureViews()
        }
    }
    
    func configureViews() {
        guard let hourForecast = self.hourForecast else { return }
        
        hourLabel.text = String(hourForecast.hour)
        tempLabel.text = "\(hourForecast.temp) °C"
        
        if let url = URL(string: hourForecast.icon) {
            ImageLoader.image(for: url) { image in
                self.iconView.image = image
            }
        }
    }
}
