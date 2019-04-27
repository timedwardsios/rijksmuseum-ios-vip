
import Foundation
import Utils

internal enum APIEndpoint {
    case art
}

internal protocol APIRequest {
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
}

internal protocol APIRequestFactory {
    func createRequest(fromAPIEndpoint apiEndpoint:APIEndpoint) -> APIRequest
}

private struct Request: APIRequest {
    var path: String
    var queryItems: [URLQueryItem]
}

internal class APIRequestFactoryDefault{}

extension APIRequestFactoryDefault: APIRequestFactory {
    
    func createRequest(fromAPIEndpoint apiEndpoint: APIEndpoint) -> APIRequest {
        switch apiEndpoint {
        case .art:
            let queryItems = [URLQueryItem(name: "ps",
                                           value: "100"),
                              URLQueryItem(name: "imgonly",
                                           value: "true"),
                              URLQueryItem(name: "s",
                                           value: "relevance")]
            return Request(path: "/collection", queryItems: queryItems)
        }
    }
}
