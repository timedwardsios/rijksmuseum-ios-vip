
import UIKit

public class DataSource<D, C: UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    public var items = [D]()

    public var configureCell:((_ cell: C, _ data:D)->C)?

    public override init() {}

    @objc public func collectionView(_ collectionView: UICollectionView,
                              numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    @objc public func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellUntyped = collectionView.dequeueReusableCell(withReuseIdentifier: C.reuseIdentifier,
                                                             for: indexPath)
        guard let cellTyped = cellUntyped as? C,
              let item =  items[safe: indexPath.row],
              let configureCell = configureCell else {
            return cellUntyped
        }

        let cellConfigured = configureCell(cellTyped, item)

        return cellConfigured
    }
}
