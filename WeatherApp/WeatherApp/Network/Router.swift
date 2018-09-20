//
//  Router.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

/// Router builds URLRequest from a target model
public struct Router {

    private let target: TargetType

    init(_ target: TargetType) {
        self.target = target
    }
    
    private func url() -> URL? {
        let fullUrl = target.baseUrl() + target.path()
        return URL(string: fullUrl.encodeURLQuery())
    }

    public func asURLRequest() -> URLRequest? {
        guard let url = url() else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = target.method().rawValue
        return request
    }
}
