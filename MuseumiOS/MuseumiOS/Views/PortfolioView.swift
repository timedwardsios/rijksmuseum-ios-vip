import UIKit
import SDWebImage
import TimKit
import Combine

class PortfolioViewController: UICollectionViewController {

    private var viewModelCancellable: Cancellable?
    private let viewModel: PortfolioViewModel

    required init?(
        coder: NSCoder,
        viewModelPublisher: CurrentValueSubject<PortfolioViewModel, Never>
    ) {
        self.viewModel = viewModelPublisher.value
        super.init(coder: coder)
        viewModelCancellable = viewModelPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: processViewModel)

    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let dataSource = UICollectionViewGenericDataSource(
        itemType: URL.self,
        cellType: ImageCell.self
    )

    private let refreshControl = UIRefreshControl()
}

//extension PortfolioViewDefault: PortfolioDisplaying {
//    func displayIsLoading(_ isLoading: Bool) {
//        DispatchQueue.main.async { [weak self] in
//            if isLoading {
//                self?.refreshControl.beginRefreshingWithAnimation()
//            } else {
//                self?.refreshControl.endRefreshing()
//            }
//        }
//    }
//
//    func displayErrorMessage(_ message: String) {
//        DispatchQueue.main.async { [weak self] in
//            let alertViewController = UIAlertController(intent: .error(message: message))
//            self?.present(alertViewController, animated: true)
//        }
//    }
//}

extension PortfolioViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupDataSource()
        viewModel.updateArts()
    }

    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectArt(atIndex: indexPath.row)
    }
}

private extension PortfolioViewController {

    func setupRefreshControl() {
        refreshControl.addTarget(
            self,
            action: #selector(refreshControlDidPullToRefresh),
            for: .valueChanged
        )
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
    }

    func setupDataSource() {
        collectionView.dataSource = dataSource
        dataSource.configureCellClosure = {
            $0.imageView.sd_setImage(with: $1)
        }
    }

    func processViewModel(viewModel: PortfolioViewModel) {
        self.dataSource.items = viewModel.imageURLs
        if isViewLoaded {
            collectionView.reloadData()
        }
    }
}

@objc private extension PortfolioViewController {
    func refreshControlDidPullToRefresh() {
        viewModel.updateArts()
    }
}
