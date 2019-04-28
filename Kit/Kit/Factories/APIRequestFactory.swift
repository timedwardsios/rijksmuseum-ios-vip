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
    func apiRequest(fromAPIEndpoint apiEndpoint: APIEndpoint) -> APIRequest
}

internal class APIRequestFactoryDefault {}

extension APIRequestFactoryDefault: APIRequestFactory {

    func apiRequest(fromAPIEndpoint apiEndpoint: APIEndpoint) -> APIRequest {
        switch apiEndpoint {
        case .art:
            return artAPIRequest()
        }
    }
}

private extension APIRequestFactoryDefault {

    struct Request: APIRequest {
        var path: String
        var queryItems: [URLQueryItem]
    }

    func artAPIRequest() -> APIRequest {
        let path = "/collection"
        let itemCountQueryItem = URLQueryItem(name: "ps", value: "100")
        let imageFilterQueryItem = URLQueryItem(name: "imgonly", value: "true")
        let sortQueryItem = URLQueryItem(name: "s", value: "relevance")
        return Request(path: path, queryItems: [itemCountQueryItem, imageFilterQueryItem, sortQueryItem])
    }
}
