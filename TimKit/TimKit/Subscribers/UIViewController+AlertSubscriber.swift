import UIKit
import Combine

public protocol AlertSubscriber: Subscriber where Input == Alert?, Failure == Never {}

public extension AlertSubscriber where Self: UIViewController {
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: Alert?) -> Subscribers.Demand {
        if let alert = input {
            self.displayAlert(alert)
        } else {
            self.attemptDismissPresentedAlert()
        }
        return .unlimited
    }

    func receive(completion: Subscribers.Completion<Never>) {}

    private func displayAlert(_ alert: Alert) {
        let alertController = UIAlertController(alert: alert)
        self.present(alertController, animated: true)
    }

    private func attemptDismissPresentedAlert() {
        if let alertController = self.presentedViewController as? UIAlertController {
            alertController.dismiss(animated: true)
        }
    }
}
