import UIKit
import SDWebImage
import TimKit
import Combine

class PortfolioViewController: UICollectionViewController, AlertSubscriber {

    private let viewModel: PortfolioViewModel

    var tokens = Set<AnyCancellable>()

    required init?(coder: NSCoder, viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var dataSource = UICollectionViewItemSource<URL, ImageCell>(collectionView: collectionView)

    private let refreshControl = UIRefreshControl()
}

extension PortfolioViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindInput()
        bindOutput()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

    func setup() {
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.dataSource = dataSource
    }

    func bindInput() {
        viewModel.$isRefreshing
            .receive(on: RunLoop.main)
            .subscribe(refreshControl)

        viewModel.$imageURLs
            .receive(on: RunLoop.main)
            .sink {
                self.dataSource.items = $0
                self.collectionView.reloadData()
        }.store(in: &tokens)

        viewModel.$alert
            .receive(on: RunLoop.main)
            .subscribe(self)
    }

    func bindOutput() {
        refreshControl.isRefreshingPublisher
            .assign(to: \.isRefreshing, on: viewModel)
            .store(in: &tokens)
    }
}
