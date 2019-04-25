
import UIKit

public extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
