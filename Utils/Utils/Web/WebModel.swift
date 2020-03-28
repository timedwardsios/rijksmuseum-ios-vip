import Foundation

public enum URLScheme: String {
    case https
}

public enum HTTPMethod: String {
    case CONNECT, DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT, TRACE
}

public protocol URLExtension {
    var path: String {get}
    var queryItems: [String: String] {get}
}

public protocol WebRequest: URLExtension {
    associatedtype JSONType: Decodable
    var httpMethod: HTTPMethod {get}
    var headers: [String: String] {get}
    var jsonType: JSONType.Type {get}
}

public extension WebRequest {

    var httpMethod: HTTPMethod {
        .GET
    }

    var headers: [String: String] {
        return [:]
    }
}

public protocol WebRepositoryConfig: URLExtension {
    var urlScheme: URLScheme {get}
    var hostname: String {get}
}
