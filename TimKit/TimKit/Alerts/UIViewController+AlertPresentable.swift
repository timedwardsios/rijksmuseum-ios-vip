import UIKit
import Combine

public protocol AlertSubscriber: SimpleSubscriber where Input == Alert {}

public extension AlertSubscriber where Self: UIViewController {

    func recieve(_ input: Alert) {
        present(
            UIAlertController(alert: input),
            animated: true
        )
    }
}
