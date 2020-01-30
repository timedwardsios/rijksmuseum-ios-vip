import UIKit
import Combine

public protocol SimpleSubscriber: Subscriber where Failure == Never {
    associatedtype Input
    func recieve(_ input: Self.Input)
}

extension SimpleSubscriber {

    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(_ input: Self.Input) -> Subscribers.Demand {
        recieve(input)
        return .unlimited
    }

    public func receive(completion: Subscribers.Completion<Never>) {}
}
