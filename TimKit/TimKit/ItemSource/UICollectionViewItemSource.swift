import UIKit
import Combine

public class UICollectionViewSource <I: Identifiable, C: UICollectionViewCell & ItemConfigurable>:
NSObject, UICollectionViewDataSource where C.I == I {

    private var items = [I]()

    private let collectionView: UICollectionView
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
    }

    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAt(indexPath)
    }
}

private extension UICollectionViewSource {
    func cellForItemAt(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.reuseIdentifier,
                                                          for: indexPath) as? C,
            let item = items[optionalAt: indexPath.row] else {
                return UICollectionViewCell()
        }

        cell.configure(with: item)

        return cell
    }
}

extension UICollectionViewSource: SimpleSubscriber {
    public func recieve(_ input: [I]) {
        items = input
        collectionView.reloadData()
    }
}
