
import Foundation
@testable import Utils

enum Seeds{
//    struct Error: Swift.Error {}
//    static let error = Error()

    static let data = UUID().uuidString.data(using: .utf8)!

    static let url = URL(string: "http://www.\(UUID().uuidString).com")!
}
