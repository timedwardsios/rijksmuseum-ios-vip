import UIKit
import SDWebImage
import MuseumKit
import TimKit
import Combine
import CombineCocoa

class PortfolioView: UITableViewController, AlertSubscriber {

    private let viewModel: PortfolioViewModel

    // all cancelled on deinit
    private var tokens: Set<AnyCancellable> = []

    required init?(coder: NSCoder, viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var collectionViewProxy: UITableViewProxy<PortfolioCell> =
        .init(tableView: tableView)
}

extension PortfolioView {

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didPullToRefresh()
    }

    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.alpha = 0.5
    }

    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.alpha = 1
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


        viewModel.portfolioCellModels
            .receive(on: RunLoop.main)
            .subscribe(collectionViewProxy)

        refreshControl?.isRefreshingPublisher
            .filter { $0 == true }
            .sink { _ in self.viewModel.didPullToRefresh() }
            .store(in: &tokens)

        collectionViewProxy.didSelectPublisher
            .sink(receiveValue: didSelectCellWithModel)
            .store(in: &tokens)
    }

    func didSelectCellWithModel(_ portfolioCellModel: PortfolioCellModel) {
        let detailsViewController: DetailsView
        detailsViewController = dependencies.resolve(imageURL: portfolioCellModel.imageURL)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
