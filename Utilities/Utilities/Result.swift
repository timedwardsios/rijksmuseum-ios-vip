
public protocol ResultError: Error {
    var rawValue:String{get}
}
public extension ResultError {
    var message:String{
        return self.rawValue
    }
}

public enum Result<T> {
    case success(T)
    case failure(ResultError)
    public var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
