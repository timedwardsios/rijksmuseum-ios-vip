
import UIKit

public extension UICollectionReusableView {
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
