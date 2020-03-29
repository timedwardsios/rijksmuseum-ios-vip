import UIKit

public extension UIAlertController {

    convenience init(alert: Alert) {

        self.init(title: alert.title, message: alert.message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alert.okHandler?()
        }

        addAction(okAction)
    }
}
