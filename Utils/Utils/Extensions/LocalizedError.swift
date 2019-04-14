import Foundation

// Can now use generic .localizedDescription on localized errors that use an enum

public extension LocalizedError where Self : RawRepresentable, RawValue == String {
    var errorDescription: String? {
        return self.rawValue
    }
}
