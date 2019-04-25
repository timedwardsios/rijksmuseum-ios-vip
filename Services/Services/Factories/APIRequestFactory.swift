
import Foundation
import Utils

enum APIEndpoint {
    case art
}

protocol APIRequest {
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
}

protocol APIRequestFactory {
    func createRequest(fromAPIEndpoint apiEndpoint:APIEndpoint) -> APIRequest
}

class APIRequestFactoryDefault{}

extension APIRequestFactoryDefault: APIRequestFactory {
    private struct Request: APIRequest {
        var path: String
        var queryItems: [URLQueryItem]
    }

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
