
import Foundation

public enum Result<Type,Error> {
    case success(Type)
    case failure(Error)
    public var value: Type? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
