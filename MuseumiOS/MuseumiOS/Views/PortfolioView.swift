import UIKit
import SDWebImage
import MuseumKit
import TimKit
import Combine
import CombineCocoa

class PortfolioView: UICollectionViewController, AlertSubscriber {

    private let viewModel: PortfolioView.Model

    private var tokens = Set<AnyCancellable>()

    required init?(coder: NSCoder, viewModel: PortfolioView.Model) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var collectionViewProxy: UICollectionViewProxy<PortfolioCell> =
        .init(collectionView: collectionView)

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        return refreshControl
    }()
}

extension PortfolioView {

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        viewDidAppearPublisher.send((isBeingPresented, isMovingToParent))
        viewModel.refreshArts()
    }

    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }
}

private extension PortfolioView {

    func bind() {

//        viewModel.$isLoading
//            .receive(on: RunLoop.main)
//            .subscribe(refreshControl)

//        viewModel.alertPublisher
//            .receive(on: RunLoop.main)
//            .subscribe(self)

//        viewDidAppearPublisher
//            .compactMap { $0.0 || $0.1 }
//            .merge(with: refreshControl.isRefreshingPublisher)
//            .receive(on: RunLoop.main)
//            .filter { $0 == true }
//            .flatMap { _ in self.viewModel.updateItems }
//            .subscribe(collectionViewProxy)

        collectionViewProxy.didSelectPublisher
            .sink(receiveValue: didSelectCellWithModel)
            .store(in: &tokens)
    }

    func didSelectCellWithModel(_ portfolioCellModel: PortfolioCell.Model) {
        let detailsViewController: DetailsView
        detailsViewController = dependencies.resolve(imageURL: portfolioCellModel.imageURL)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
