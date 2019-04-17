import UIKit

// Can now use .reuseIdentifier on collection and table view cell objects

public extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
