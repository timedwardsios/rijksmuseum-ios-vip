
public protocol ResultError: Error {
    var rawValue:String{get}
}
public extension ResultError {
    var message:String{
        return self.rawValue
    }
}

public enum Result<Type> {
    case success(Type)
    case failure(ResultError)
}
