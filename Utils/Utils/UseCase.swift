import Foundation
import RxSwift

public protocol UseCase {
    associatedtype A
    associatedtype R
    func execute(_ argument: A) -> Observable<R>
}
