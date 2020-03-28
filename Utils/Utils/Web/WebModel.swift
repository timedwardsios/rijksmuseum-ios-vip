import Foundation

public enum HTTPMethod: String {
    case CONNECT, DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT, TRACE
}

public protocol WebRequest {
    associatedtype JSONType: Decodable
    var url: URL { get }
    var httpMethod: HTTPMethod {get}
    var headers: [String: String] {get}
    var jsonType: JSONType.Type {get}
}
