import UIKit
import Combine

public protocol AlertSubscriber: Subscriber {}

extension AlertSubscriber where Self: UIViewController {

    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(_ input: Alert) -> Subscribers.Demand {
        present(UIAlertController(alert: input), animated: true)
        return .unlimited
    }

    public func receive(completion: Subscribers.Completion<Never>) { }
}
