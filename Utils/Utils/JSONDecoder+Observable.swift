import Foundation
import RxSwift

extension Observable where Element == Data {
    func decode<T: Decodable>(using jsonDecoder: JSONDecoder) -> Observable<T> {
        map {
            try jsonDecoder.decode(T.self, from: $0)
        }
    }
}
