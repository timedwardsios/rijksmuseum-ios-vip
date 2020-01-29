import Foundation

public struct Hostname: RawRepresentable {
    public let rawValue: String
    public init?(rawValue: String) {
        guard !rawValue.isEmpty else {
            return nil
        }
        self.rawValue = rawValue
    }
}
