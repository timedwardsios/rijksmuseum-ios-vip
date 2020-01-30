import UIKit
import Combine

public protocol AlertSubscriber: SimpleSubscriber where Input == Alert? {}

public extension AlertSubscriber where Self: UIViewController {

    func recieve(_ input: Alert?) {

        let currentAlert = self.presentedViewController as? UIAlertController

        switch (input, currentAlert) {
        case let (alert?, nil):
            present(UIAlertController(alert: alert), animated: true)
        case let (nil, currentAlert?):
            currentAlert.dismiss(animated: true)
        default:
            break
        }
    }
}
