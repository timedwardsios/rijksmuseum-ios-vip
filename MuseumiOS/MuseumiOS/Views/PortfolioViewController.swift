import UIKit
import SDWebImage
import MuseumKit
import TimKit
import Combine
import CombineCocoa

class PortfolioViewController: UICollectionViewController, AlertSubscriber {

    private let viewModel: PortfolioViewModel

    private var tokens = Set<AnyCancellable>()

    required init?(coder: NSCoder, viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    let viewDidAppearPublisher = PassthroughSubject<(isBeingPresented: Bool, isMovingToParent: Bool), Never>()

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

extension PortfolioViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearPublisher.send((isBeingPresented, isMovingToParent))
    }

    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }
}

private extension PortfolioViewController {

    func bind() {

        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .subscribe(refreshControl)

        viewModel.alertPublisher
            .receive(on: RunLoop.main)
            .subscribe(self)

        viewDidAppearPublisher
            .compactMap { $0.0 || $0.1 }
            .merge(with: refreshControl.isRefreshingPublisher)
            .receive(on: RunLoop.main)
            .filter { $0 == true }
            .flatMap { _ in self.viewModel.updateItems }
            .subscribe(collectionViewProxy)

        collectionViewProxy.didSelectPublisher
            .sink(receiveValue: didSelectCellWithModel)
            .store(in: &tokens)
    }

    func didSelectCellWithModel(_ portfolioCellModel: PortfolioCellModel) {
        let detailsViewController: DetailsViewController
        detailsViewController = dependencies.resolve(imageURL: portfolioCellModel.imageURL)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
