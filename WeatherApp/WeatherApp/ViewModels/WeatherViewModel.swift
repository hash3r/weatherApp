//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

class WeatherViewModel: WeatherViewModelProtocol {
    
    private(set) var forecast = ForecastModel()
    private(set) var isLoading = false
    internal var queryModel: WeatherQueryModel!
    internal var dataTask: URLSessionDataTask?
    
    init() {
        configureQueryModel()
    }
    
    private func configureQueryModel() {
        queryModel = WeatherQueryModel()
    }
    
    func loadData(_ success: @escaping SuccessCompletion<Bool>, _ failure: @escaping FailureCompletion) {
        if self.isLoading == true {
            resetRequest()
        }
        self.isLoading = true

        let target = WeatherTarget.forecast(query: self.queryModel)
        dataTask = RestAPI.shared.mappableRequest(target, success: { (forecast: ForecastModel) in
            self.forecast = forecast
            self.isLoading = false
            DispatchQueue.main.async {
                success(true)
            }
        }) { error in
            self.isLoading = false
            DispatchQueue.main.async {
                failure(error)
            }
        }
    }
    
    func resetRequest() {
        dataTask?.cancel()
        self.isLoading = false
    }
}

