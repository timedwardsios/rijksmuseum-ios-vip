import UIKit

public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UIViewController: ReuseIdentifiable {}

extension UITableViewCell: ReuseIdentifiable {}

extension UICollectionReusableView: ReuseIdentifiable {}
