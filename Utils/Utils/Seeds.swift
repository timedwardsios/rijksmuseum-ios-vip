
import Foundation

public enum Seeds{

    struct ErrorSeed: LocalizedError {
        var errorDescription: String? {
            return UUID().uuidString
        }
    }
    
    public static let error:Error = ErrorSeed()

    public static let data = UUID().uuidString.data(using: .utf8)!

    public static let url = URL(string: "http://www.\(UUID().uuidString).com")!

    public static let urlResponse = HTTPURLResponse(url: Seeds.url,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)

    public static let string = UUID().uuidString

    public static let urlQueryItem = URLQueryItem(name: Seeds.string, value: Seeds.string)
}
