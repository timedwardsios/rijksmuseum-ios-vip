import Foundation

public enum Seeds {

    static var string: String {
        return UUID().uuidString
    }

    static var error: Error {
        return ErrorMock()
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
}