import UIKit

public extension UIAlertController {

    enum Intent {
        case error(message: String)
    }

    convenience init(intent: Intent) {

        let title: String
        let message: String
        let actions: [UIAlertAction]

        switch intent {
        case .error(let errorMessage):

            title = "Error"
            message = errorMessage
            actions = [.init(title: "OK", style: .default)]
        }

        self.init(title: title,
                  message: message,
                  preferredStyle: .alert)

        for action in actions {
            addAction(action)
        }
    }
}
