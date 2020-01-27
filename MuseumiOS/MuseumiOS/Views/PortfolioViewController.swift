import UIKit
import SDWebImage
import TimKit

class PortfolioViewController: UICollectionViewController {

    let interactor: PortfolioInteracting

    required init?(coder: NSCoder, interactor: PortfolioInteracting) {
        self.interactor = interactor
        super.init(coder: coder)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let dataSource = UICollectionViewGenericDataSource(
        itemType: URL.self,
        cellType: ImageCell.self
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupDataSource()
        interactor.fetchArts()
    }

    private let refreshControl = UIRefreshControl()
}

extension PortfolioViewController: PortfolioDisplaying {
    func displayIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.refreshControl.beginRefreshingWithAnimation()
            } else {
                self?.refreshControl.endRefreshing()
            }
        }
    }

    func displayImageURLs(_ urls: [URL]) {
        DispatchQueue.main.async { [weak self] in
            self?.setImageURLs(urls)
        }
    }

    func displayErrorMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alertViewController = UIAlertController(intent: .error(message: message))
            self?.present(alertViewController, animated: true)
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
        interactor.selectArt(atIndex: indexPath.row)
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

    func setImageURLs(_ urls: [URL]) {
        dataSource.items = urls
        collectionView.reloadData()
    }
}

@objc private extension PortfolioViewController {
    func refreshControlDidPullToRefresh() {
        interactor.fetchArts()
    }
}
