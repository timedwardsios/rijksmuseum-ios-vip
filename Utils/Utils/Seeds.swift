
import Foundation

public protocol Seedable {
    static var string: String {get}
    static var urlQueryItem: URLQueryItem {get}
}

public extension Seedable {
    static var string: String {
        return UUID().uuidString
    }

    static var urlQueryItem: URLQueryItem {
        return URLQueryItem(name: string,
                            value: string)
    }
}

private struct ErrorSeed: Error {}

private extension Seedable {
    static var error: Error {
        return ErrorSeed()
    }

    static var data: Data {
        return string.data(using: .utf8)!
    }

    static var url: URL {
        return URL(string: "http://www.\(string).com")!
    }

    static var urlResponse: URLResponse {
        return HTTPURLResponse(url: url,
                               statusCode: 200,
                               httpVersion: nil,
                               headerFields: nil)!
    }
}
