
import Foundation

public extension LocalizedError where Self : RawRepresentable, RawValue == String {
    var errorDescription: String? {
        return self.rawValue
    }
}
