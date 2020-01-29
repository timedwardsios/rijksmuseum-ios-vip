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

public protocol APIRequest: URLExtension {
    var method: HTTPMethod {get}
}

public protocol APIConfig: URLExtension {
    var scheme: URLScheme {get}
    var hostname: Hostname {get}
}

public protocol APIResponseModel {
    associatedtype DecodableType: Decodable
    var decodableType: DecodableType.Type {get}
}

public protocol APIOperation: APIRequest, APIResponseModel {}
