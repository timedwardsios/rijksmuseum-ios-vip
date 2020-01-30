import UIKit
import Combine

public class UICollectionViewProxy <C: UICollectionViewCell & ViewModelSettable>:
NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    private var viewModels = [C.VM]()

    private let didSelectSubject = PassthroughSubject<C.VM, Never>()

    public lazy var didSelectPublisher: AnyPublisher<C.VM, Never> = didSelectSubject.eraseToAnyPublisher()

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
        viewModels.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAt(indexPath)
    }

    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = viewModels[optionalAt: indexPath.row] {
            didSelectSubject.send(viewModel)
        }
    }
}

private extension UICollectionViewProxy {
    func cellForItemAt(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.reuseIdentifier,
                                                          for: indexPath) as? C,
            let viewModel = viewModels[optionalAt: indexPath.row] else {
                return UICollectionViewCell()
        }

        cell.setViewModel(viewModel)

        return cell
    }
}

extension UICollectionViewProxy: SimpleSubscriber {
    public func recieve(_ input: [C.VM]) {
        viewModels = input
        collectionView.reloadData()
    }
}
