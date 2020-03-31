import Foundation

public enum HTTPMethod: String {
    case CONNECT, DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT, TRACE
}

public protocol WebServiceConfig {
    var basePath: String { get }
    var queryItems: [URLQueryItem] { get }
}

public protocol WebRequest {
    associatedtype ResponseJSONType: Decodable
    var pathExtension: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
}

public extension WebRequest {
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }
}
