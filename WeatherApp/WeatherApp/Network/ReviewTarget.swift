////
////  ReviewTarget.swift
////  GYGtest
////
////  Created by Hnatiuk, Volodymyr on 25.08.18.
////  Copyright © 2018 GYG. All rights reserved.
////
//
//import Alamofire
//
//enum ReviewTarget {
//    case search(query: ReviewQueryModel)
//}
//
//extension ReviewTarget: TargetType {
//    
//    func baseUrl() -> PathType {
//        return Config.GYGServer.BaseUrl + Config.GYGServer.ApiVersion
//    }
//    
//    func path() -> PathType {
//        switch self {
//        case .search(let query):
//            var path = "/"
//            path += query.city + "/"
//            path += query.tour + "/"
//            path += "reviews.json?"
//            path += "count=\(query.pagination.count)"
//            path += "&page=\(query.pagination.page)"
//            path += "&rating=\(query.rating)"
//            path += "&sortBy=\(query.sortBy.rawValue)"
//            path += "&direction=\(query.sortDirection.rawValue)"
//            return path
//        }
//    }
//    
//    func method() -> Alamofire.HTTPMethod {
//        switch self {
//        case .search: return .get
//        }
//    }
//}
