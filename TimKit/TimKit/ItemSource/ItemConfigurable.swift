import UIKit

public protocol ItemConfigurable {
    associatedtype I
    func configure(with item: I)
}
