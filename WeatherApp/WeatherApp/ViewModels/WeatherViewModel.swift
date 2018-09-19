//
//  WeatherViewModel.swift
//  GYGtest
//
//  Created by Hnatiuk, Volodymyr on 25.08.18.
//  Copyright © 2018 GYG. All rights reserved.
//


class WeatherViewModel: WeatherViewModelProtocol {
    
    
    private(set) var weatherModel = [WeatherModel]()
    private(set) var isLoading = false
    internal var queryModel: WeatherQueryModel!
    
    init() {
        configureQueryModel()
    }
    
    private func configureQueryModel() {
        queryModel = WeatherQueryModel()
        //Mock data for demo
//        queryModel?.city = "berlin-l17"
//        queryModel?.tour = "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776"
    }
    
    func loadData() {
        if (self.isLoading == true) {
//            return Promise.value(false)
        }
        self.isLoading = true

//        let target = ReviewTarget.search(query: self.queryModel)
//
//
//        Rest.shared.mappableRequest(target).map(on: DispatchQueue.global(), { (searchResult: ReviewsResponseModel) -> () in
//                self.queryModel.pagination.totalCount = searchResult.pagination.totalCount
//                self.queryModel.pagination.incrementPage()
//                self.searchReviews.append(contentsOf: searchResult.reviews)
//
//                seal.fulfill(true)
//                self.isLoading = false
//            }).catch ({ (error) in
//                seal.reject(error)
//                self.isLoading = false
//            })
    }
    
    
    func resetRequest() {
        self.isLoading = false
        self.weatherModel.removeAll(keepingCapacity: true)
    }
}

