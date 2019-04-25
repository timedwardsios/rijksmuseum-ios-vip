
import Foundation

private struct ErrorSeed: Error {}



internal enum Seeds: Seedable {}

public protocol Seedable {}

public extension Seedable {
    static var string: String {
        return UUID().uuidString
    }

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

    static var urlQueryItem: URLQueryItem {
        return URLQueryItem(name: string,
                            value: string)
    }



    static var networkRequest: NetworkRequest {

        struct NetworkRequestSeed: NetworkRequest {
            var url: URL
            var method: NetworkMethod
        }

        return NetworkRequestSeed(url: url, method: network)
    }
}
