import UIKit

public class UITableViewGenericDataSource<ItemType, CellType: UITableViewCell>: NSObject, UITableViewDataSource {

    public var items = [ItemType]()

    public var configureCellClosure:((_ cell: CellType, _ item: ItemType) -> Void)?

    override public init() {}

    @objc public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numberOfItems()
    }

    @objc public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return cellForIndexPath(indexPath: indexPath, ofTableView: tableView)
    }
}

private extension UITableViewGenericDataSource {

    func numberOfItems() -> Int {
        return items.count
    }

    func cellForIndexPath(indexPath: IndexPath,
                          ofTableView tableView: UITableView) -> UITableViewCell {

        let dequeuedCell = dequeuedCellFromIndexPath(indexPath, ofTableView: tableView)

        guard let typedCell = typedCellFromUntypedCell(dequeuedCell) else {
            return dequeuedCell
        }

        guard let item = itemAtIndexPath(indexPath) else {
            return dequeuedCell
        }

        configureCell(typedCell, usingItem: item)

        return typedCell
    }
}

private extension UITableViewGenericDataSource {

    func dequeuedCellFromIndexPath(_ indexPath: IndexPath,
                                   ofTableView tableView: UITableView) -> UITableViewCell {

        return tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier, for: indexPath)
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> ItemType? {

        let index = indexPath.row

        return items[optionalAt: index]
    }

    func typedCellFromUntypedCell(_ untypedCell: UITableViewCell) -> CellType? {
        return untypedCell as? CellType
    }

    func configureCell(_ cell: CellType, usingItem item: ItemType) {

        if let configureCellClosure = configureCellClosure {

            configureCellClosure(cell, item)
        }
    }
}
