
import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
    public var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
