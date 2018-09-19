//
//  Router.swift
//  GYGtest
//
//  Created by Hnatiuk, Volodymyr on 25.08.18.
//  Copyright © 2018 GYG. All rights reserved.
//

//import Alamofire
//import SwiftyJSON

///// Router builds URLRequest from a target model
//public struct Router {
//
//    private let target: TargetType
//
//    init(_ target: TargetType) {
//        self.target = target
//    }
//    
//    private func url() -> URL {
//        let fullUrl = target.baseUrl() + target.path()
//        return URL(string: fullUrl.encodeURLQuery())!
//    }
//    
//    private func headers() -> HTTPHeaders {
//        return target.headers()
//    }
//}
//
//// MARK: URLRequestConvertible
//extension Router: URLRequestConvertible {
//
//    public func asURLRequest() -> URLRequest {
//        var request = try! URLRequest(url: url(), method: target.method(), headers: headers())
//        request.httpMethod = target.method().rawValue
//        
//        if let params = target.params() {
//            let data = try? JSON(params).rawData()
//            request.httpBody = data
//        }
//        return request
//    }
//}
