
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
    func createAPIRequest(fromAPIEndpoint apiEndpoint:APIEndpoint) -> APIRequest
}

private struct Request: APIRequest {
    var path: String
    var queryItems: [URLQueryItem]
}

internal class APIRequestFactoryDefault{}

extension APIRequestFactoryDefault: APIRequestFactory {
    
    func createAPIRequest(fromAPIEndpoint apiEndpoint: APIEndpoint) -> APIRequest {
        switch apiEndpoint {
        case .art:
            return createArtAPIRequest()
        }
    }
}

private extension APIRequestFactoryDefault {

    func createArtAPIRequest() -> APIRequest {
        let path = "/collection"
        let itemCountQueryItem = URLQueryItem(name: "ps", value: "100")
        let imageFilterQueryItem = URLQueryItem(name: "imgonly", value: "true")
        let sortQueryItem = URLQueryItem(name: "s", value: "relevance")
        return Request(path: path, queryItems: [itemCountQueryItem, imageFilterQueryItem, sortQueryItem])
    }
}
