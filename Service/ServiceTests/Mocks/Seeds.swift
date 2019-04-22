
import Foundation
import Utils
@testable import Service

enum Seeds{
    struct Error: Swift.Error {}
    static let error = Error()

    static let url = URL(string: "http://www.google.com")!
}
