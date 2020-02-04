import UIKit
import Combine

extension UIImageView: Subscriber {
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(_ input: UIImage) -> Subscribers.Demand {
        return .unlimited
    }

    public func receive(completion: Subscribers.Completion<Never>) {}
}
