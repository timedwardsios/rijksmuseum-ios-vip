import UIKit
import SDWebImage
import TimKit

class PortfolioViewController: UICollectionViewController {

    let interactor: PortfolioInteracting
    let router: PortfolioRouting

    init(interactor: PortfolioInteracting,
         router: PortfolioRouting) {
        self.interactor = interactor
        self.router = router
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let dataSource = UICollectionViewGenericDataSource<URL, PortfolioImageCell>()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupRefreshControl()
        interactor.fetchArts()
        collectionView.backgroundColor = .red
    }
}

extension PortfolioViewController: PortfolioDisplaying {
    func displayIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.setIsLoading(isLoading)
        }
    }

    func displayImageURLs(_ urls: [URL]) {
        DispatchQueue.main.async { [weak self] in
            self?.setImageURLs(urls)
        }
    }

    func displayErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(intent: .error(message: message))
            self.present(alertViewController, animated: true)
        }
    }
}

extension PortfolioViewController {
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectURLAtIndex(indexPath)
    }
}

private extension PortfolioViewController {
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshControlDidPullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
    }

    func setupDataSource() {
        dataSource.configureCellClosure = configureCell
        collectionView.dataSource = dataSource
    }

    @objc func refreshControlDidPullToRefresh() {
        interactor.fetchArts()
    }

    func didSelectURLAtIndex(_ indexPath: IndexPath) {
        interactor.selectArt(atIndex: indexPath.row)
        router.routeToListing()
    }

    func configureCell(_ cell: PortfolioImageCell, withURL url: URL) {
        cell.imageView.sd_setImage(with: url)
    }

    func setImageURLs(_ urls: [URL]) {
        dataSource.items = urls
        collectionView.reloadData()
    }

    func setIsLoading(_ isLoading: Bool) {
        if isLoading {
            refreshControl.beginRefreshingWithAnimation()
        } else {
            refreshControl.endRefreshing()
        }
    }
}
