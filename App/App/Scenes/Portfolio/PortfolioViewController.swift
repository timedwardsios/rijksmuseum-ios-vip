
import UIKit
import SDWebImage
import Utils

class PortfolioViewController: UICollectionViewController, StoryboardLoadable {

    var interactor: PortfolioInteracting?
    var router: PortfolioRouting?

    private let dataSource = UICollectionViewGenericDataSource<URL, PortfolioImageCell>()
    private let refreshControl = UIRefreshControl()
    private var imageUrls = [URL]()
}

// MARK: - Overrides
extension PortfolioViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh),
                                 for: .valueChanged)
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        interactor?.fetchArts()

        dataSource.configureCell = { (cell: PortfolioImageCell, item: URL) -> PortfolioImageCell in
            cell.imageView.sd_setImage(with: item)
            return cell
        }

        collectionView.dataSource = dataSource
    }
}

// MARK: - UICollectionViewDelegate
extension PortfolioViewController {
    override func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        interactor?.selectArt(atIndex: indexPath.row)
        router?.routeToListing()
    }
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

    func displayImageUrls(_ urls: [URL]) {
        DispatchQueue.main.async { [weak self] in
            self?.dataSource.items = urls
            self?.collectionView.reloadData()
        }
    }

    func displayErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(intent: .error(message: message))
            self.present(alertViewController, animated: true)
        }
    }
}

private extension PortfolioViewController {

    @objc func didPullToRefresh() {
        interactor?.fetchArts()
    }
}
