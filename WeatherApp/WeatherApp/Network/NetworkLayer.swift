import Foundation

typealias NetworkCompletion = (Data?, URLResponse?, Error?) -> Void
public typealias ErrorBlock = (NetworkError) -> Void

public enum NetworkError: Error {
    case requestError(_ error: String)
    case responseError(_ error: Error)
    case parseError(_ type: String)
    case serverError
    
    func description() -> String {
        switch self {
        case .requestError(let error):
            return error
        case .responseError(let error):
            return error.localizedDescription
        case .parseError(let type):
            return "Unable to parse the response in given type: \(type)"
        case .serverError:
            return "Server error"
        default:
            return "Something went wrong. Please try again later"
        }
    }
}

open class NetworkLayer {
    
//    static let genericdefaultError =

    public init() {
    }

    open func get<T: Decodable>(_ urlString: String, headers: [String: String] = [:], successBlock: @escaping (T) -> Void, errorBlock: @escaping ErrorBlock) {

        let completionHandler: NetworkCompletion = { (data, urlResponse, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                errorBlock(.responseError(error))
                return
            }

            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    return errorBlock(.parseError(String(describing: T.self)))
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successBlock(responseObject)
                    return
                }
            }
            errorBlock(.serverError)
        }

        guard let url = URL(string: urlString) else {
            return errorBlock(.requestError("Unable to create URL from given string"))
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }


    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }

    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else { return false }
        return isSuccessCode(urlResponse.statusCode)
    }
}
