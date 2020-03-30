import Foundation

public enum Loadable<T> {

    case loading

    case success(T)

    case failure(Error)

    public var value: T? {
        switch self {
        case let .success(last):
            return last
        default:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }
}
