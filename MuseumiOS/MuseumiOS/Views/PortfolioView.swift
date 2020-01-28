import UIKit
import SDWebImage
import TimKit
import Combine

class PortfolioViewController: UICollectionViewController {

    private let viewModel: PortfolioViewModel

    var tokens = Set<AnyCancellable>()

    required init?(coder: NSCoder, viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
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

extension PortfolioViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupRefreshControl()
        setupDataSource()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.updateArts()
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

    func setupBindings() {
        viewModel.$isFetching
            .receive(on: RunLoop.main)
            .sink {
                if $0 == true {
                    self.refreshControl.beginRefreshingWithAnimation()
                } else {
                    self.refreshControl.endRefreshing()
                }
        }.store(in: &tokens)

        viewModel.$imageURLs
            .receive(on: RunLoop.main)
            .sink {
                self.dataSource.items = $0
                self.collectionView.reloadData()
        }.store(in: &tokens)
    }

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
}

@objc private extension PortfolioViewController {
    func refreshControlDidPullToRefresh() {
        viewModel.updateArts()
    }
}
