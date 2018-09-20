//
//  DayWeatherCell.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {
    
    static let Key = "DayWeatherCell"

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var hoursForecastCollection: UICollectionView!
    
    var dayForecast: [WeatherModel]? {
        didSet {
            guard let _ = dayForecast else { return }
            self.configureLabels()
            hoursForecastCollection.reloadData()
        }
    }
    
    func configureLabels() {
        guard let dayForecast = self.dayForecast?.first else { return }

        dateLabel.text = WeatherDateFormatter.dayFormat.string(from: dayForecast.date)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension DayWeatherCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dayForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourWeatherCell.Key, for: indexPath) as! HourWeatherCell
        cell.hourForecast = dayForecast?[indexPath.row]
        return cell
    }

}
