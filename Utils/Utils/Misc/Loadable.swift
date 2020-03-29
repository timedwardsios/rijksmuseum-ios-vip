import Combine
import Foundation

public enum Loadable<T> {

    case notRequested

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

public extension Publisher {
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        sink(
            receiveCompletion: {
                if case let .failure(error) = $0 {
                    completion(.failure(error))
                }
            },
            receiveValue: {
                completion(.success($0))
            }
        )
    }

    func assignLoadable<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Loadable<Self.Output>>,
        on object: Root
    ) -> AnyCancellable {
        sinkToLoadable { value in
            object[keyPath: keyPath] = value
        }
    }
}
