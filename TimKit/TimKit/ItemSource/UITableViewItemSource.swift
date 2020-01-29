import UIKit
import Combine

public class UITableViewItemSource <I, C: UITableViewCell & ItemConfigurable>:
NSObject, UITableViewDataSource where C.I == I {

    public var items = [I]()

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: C.reuseIdentifier,
            for: indexPath) as? C,
            let item = items[optionalAt: indexPath.row] else {
                return UITableViewCell()
        }

        cell.configure(with: item)

        return cell
    }
}

extension UITableViewItemSource: SimpleSubscriber {
    public func recieve(_ input: [I]) {
        items = input
    }
}
