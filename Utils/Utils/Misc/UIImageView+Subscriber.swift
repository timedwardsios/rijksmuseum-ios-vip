import Combine
import UIKit

extension UIImageView: Subscriber {
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(_ input: UIImage) -> Subscribers.Demand {
        .unlimited
    }

    public func receive(completion: Subscribers.Completion<Never>) {}
}
