
import UIKit

extension UICollectionReusableView {
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
