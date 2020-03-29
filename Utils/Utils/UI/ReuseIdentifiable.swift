import UIKit

public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UIViewController: ReuseIdentifiable {}

extension UITableViewCell: ReuseIdentifiable {}

extension UICollectionReusableView: ReuseIdentifiable {}
