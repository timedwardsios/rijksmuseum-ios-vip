import UIKit
import Combine

public class UICollectionViewProxy <I, C: UICollectionViewCell & ItemConfigurable>:
NSObject, UICollectionViewDataSource, UICollectionViewDelegate where C.I == I {

    private var items = [I]()

    @Published public var selectedItem: I? = nil

    private let collectionView: UICollectionView
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAt(indexPath)
    }


    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        if let item = items[optionalAt: indexPath.row] {
            selectedItem = item
        }
    }
}

private extension UICollectionViewProxy {
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

extension UICollectionViewProxy: SimpleSubscriber {
    public func recieve(_ input: [I]) {
        items = input
        collectionView.reloadData()
    }
}
