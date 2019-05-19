import UIKit

public extension UICollectionReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
