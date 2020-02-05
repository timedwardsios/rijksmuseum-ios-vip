import UIKit

extension UIAlertController {

    public convenience init(alert: Alert) {

        self.init(title: alert.title, message: alert.message, preferredStyle: .alert)

        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                alert.okHandler?()
        })

        addAction(okAction)
    }
}
