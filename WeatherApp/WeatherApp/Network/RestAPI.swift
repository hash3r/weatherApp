//
//  RestAPI.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import Foundation

public typealias NetworkCompletion = (Data?, URLResponse?, Error?) -> Void
public typealias SuccessCompletion<T> = (T) -> ()
public typealias FailureCompletion = (NetworkError) -> Void

open class RestAPI {

    static let shared = RestAPI()
    
    public init() {
        
    }

    @discardableResult
    open func mappableRequest<T: Decodable>(_ target: TargetType, success: @escaping SuccessCompletion<T>, failure: @escaping FailureCompletion) -> URLSessionDataTask? {
        
        guard let request = Router(target).asURLRequest() else {
            failure(.requestError("Unable to create URL from given string"))
            return nil
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: responseHandler(success, failure))
        task.resume()
        return task
    }
    
    open func responseHandler<T: Decodable>(_ success: @escaping SuccessCompletion<T>, _ failure: @escaping FailureCompletion) -> NetworkCompletion {
        
        return { (data, response, error) in
            if let error = error {
                //debugPrint(error.localizedDescription)
                failure(.responseError(error))
                return
            }
            if self.validate(response) {
                if let data = data {
                    do {
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        success(responseObject)
                    } catch  {
                        failure(.parseError(error.localizedDescription))
                    }
                } else {
                    failure(.parseError(String(describing: T.self)))
                }
            } else {
                failure(.serverError)
            }
        }
    }

    private func validate(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else { return false }
        return validateStatusCode(urlResponse.statusCode)
    }
    
    private func validateStatusCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
