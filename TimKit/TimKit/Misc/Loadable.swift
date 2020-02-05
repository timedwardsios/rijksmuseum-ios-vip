import Foundation
import Combine

public enum Loadable<T> {

    case notRequested
    case loading
    case success(T)
    case failure(Error)

    var value: T? {
        switch self {
        case let .success(last): return last
        default: return nil
        }
    }
    var error: Error? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}

public extension Publisher {
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: {
            if case let .failure(error) = $0 {
                completion(.failure(error))
            }
        }, receiveValue: {
            completion(.success($0))
        })
    }

    func assignToLoadable<Root>(to keyPath: ReferenceWritableKeyPath<Root, Loadable<Self.Output>>, on object: Root) -> AnyCancellable {
        sinkToLoadable { value in
            object[keyPath: keyPath] = value
        }
    }
}
