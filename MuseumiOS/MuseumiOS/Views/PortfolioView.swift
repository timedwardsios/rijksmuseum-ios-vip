import UIKit
import SDWebImage
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

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var collectionViewSource: UICollectionViewProxy<URL, ImageCell> = .init(collectionView: collectionView)

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
        bindInput()
        bindOutput()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: Publisher
        viewModel.viewDidAppear = true
    }

    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        viewModel.selectArt(atIndex: indexPath.row)
    }
}

private extension PortfolioViewController {

    func bindInput() {
        viewModel.$isRefreshing
            .receive(on: RunLoop.main)
            .subscribe(refreshControl)

        viewModel.$imageURLs
            .receive(on: RunLoop.main)
            .subscribe(collectionViewSource)

        viewModel.$alert
            .receive(on: RunLoop.main)
            .subscribe(self)
    }

    func bindOutput() {
        refreshControl.isRefreshingPublisher
            .assign(to: \.isRefreshing, on: viewModel)
            .store(in: &tokens)

        collectionViewSource.$selectedItem
            .assign(to: \.selectedURL, on: viewModel)
            .store(in: &tokens)
    }
}
