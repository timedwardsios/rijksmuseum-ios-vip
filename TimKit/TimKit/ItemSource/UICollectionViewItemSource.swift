import UIKit
import Combine

public class UICollectionViewItemSource <I, C: UICollectionViewCell & ItemConfigurable>:
NSObject, UICollectionViewDataSource where C.I == I {

    public var items = [I]()

    private let collectionView: UICollectionView

    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: C.reuseIdentifier,
            for: indexPath) as? C,
            let item = items[optionalAt: indexPath.row] else {
                return UICollectionViewCell()
        }

        cell.configure(with: item)

        return cell
    }
}

extension UICollectionViewItemSource: SimpleSubscriber {
    public func recieve(_ input: [I]) {
        items = input
    }
}
