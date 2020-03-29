import Foundation

public protocol WebRequest {
    associatedtype ResponseJSONType: Decodable
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String] { get }
}

public enum HTTPMethod: String {
    case CONNECT, DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT, TRACE
}

public extension WebRequest {
    var httpMethod: HTTPMethod {
        .GET
    }

    var headers: [String: String] {
        [:]
    }
}
