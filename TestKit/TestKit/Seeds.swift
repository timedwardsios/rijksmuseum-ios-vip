import Foundation

public enum Seeds {
    public static var int: Int {
        return Int.random(in: 0 ... 10000)
    }

    public static var string: String {
        return UUID().uuidString
    }

    public static var error: Error {
        return ErrorMock()
    }

    public static var data: Data {
        return string.data(using: .utf8)!
    }

    public static var url: URL {
        return URL(string: "http://www.\(string).com")!
    }

    public static var urlResponse: URLResponse {
        return HTTPURLResponse(url: url,
                               statusCode: 200,
                               httpVersion: nil,
                               headerFields: nil)!
    }

    public static var urlQueryItem: URLQueryItem {
        return URLQueryItem(name: string,
                            value: string)
    }
}
