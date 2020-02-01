import UIKit
import Combine

public protocol SimpleSubscriber: Subscriber where Failure == Never, Input == I {
    associatedtype I
    func recieve(_ input: I)
}

public extension SimpleSubscriber {

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: I) -> Subscribers.Demand {
        recieve(input)
        return .unlimited
    }

    func receive(completion: Subscribers.Completion<Never>) {}
}
