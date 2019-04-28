
import UIKit

public class UICollectionViewGenericDataSource<ItemType, CellType: UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    public var items = [ItemType]()

    public var configureCell:((_ cell: CellType, _ item:ItemType)->CellType)?

    override public init() {}

    @objc public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems()
    }

    @objc public func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForIndexPath(indexPath: indexPath, ofCollectionView: collectionView)
    }
}

private extension UICollectionViewGenericDataSource {
    func numberOfItems() -> Int {
        return items.count
    }

    func cellForIndexPath(indexPath: IndexPath, ofCollectionView collectionView: UICollectionView) -> UICollectionViewCell {

        let dequeuedCell = dequeuedCellFromIndexPath(indexPath, ofCollectionView: collectionView)

        guard let typedCell = typedCellFromUntypedCell(dequeuedCell) else {
            return dequeuedCell
        }

        guard let item = itemAtIndexPath(indexPath) else {
            return dequeuedCell
        }

        let configuredCell = configureCell(typedCell, usingItem: item)

        return configuredCell
    }
}

private extension UICollectionViewGenericDataSource {

    func dequeuedCellFromIndexPath(_ indexPath:IndexPath, ofCollectionView collectionView: UICollectionView) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier,
                                                  for: indexPath)
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> ItemType? {
        let index = indexPath.row
        return items[optionalAt: index]
    }

    func typedCellFromUntypedCell(_ untypedCell: UICollectionViewCell) -> CellType? {
        return untypedCell as? CellType
    }

    func configureCell(_ cell:CellType, usingItem item: ItemType) -> CellType {
        if let configureCellClosure = configureCell {
            return configureCellClosure(cell, item)
        }
        return cell
    }
}
