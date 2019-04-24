
import Foundation
@testable import Utils

enum Seeds{
    struct Error: LocalizedError {
        var errorDescription: String? {
            return UUID().uuidString
        }
    }
    static let error = Error()

    static let data = UUID().uuidString.data(using: .utf8)!

    static let url = URL(string: "http://www.\(UUID().uuidString).com")!

    static let urlResponse = HTTPURLResponse(url: Seeds.url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil)
}
