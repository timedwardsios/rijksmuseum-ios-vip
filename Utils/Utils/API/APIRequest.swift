import Foundation

public enum HTTPMethod: String {
    case CONNECT, DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT, TRACE
}

public protocol APIConfig {
    var basePath: String { get }
    var queryItems: [URLQueryItem] { get }
}

public protocol APIRequest {
    associatedtype ResponseJSONType: Decodable
    var pathExtension: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
}

public extension APIRequest {
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }
}
