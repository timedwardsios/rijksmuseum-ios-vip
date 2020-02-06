import UIKit
import Combine
import CombineCocoa
import TinyConstraints
import MuseumApp
import TimKit

class ArtCollectionViewController: UIViewController {

    private var subscriptions: Set<AnyCancellable> = []

    private let viewModel: ArtCollectionViewModel

    init(viewModel: ArtCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError() }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        return refreshControl
    }()

    private lazy var tableViewProxy = PortfolioTableViewProxy(tableView: tableView)
}

extension ArtCollectionViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.isAppeared = true
    }
}

private extension ArtCollectionViewController {

    func bind() {
        viewModel.$arts
            .receive(on: RunLoop.main)
            .assign(to: \.arts, on: tableViewProxy)
            .store(in: &subscriptions)

        viewModel.$isRequestingRefresh
            .receive(on: RunLoop.main)
            .subscribe(refreshControl)

        refreshControl.isRefreshingPublisher
            .assign(to: \.isRequestingRefresh, on: viewModel)
            .store(in: &subscriptions)

        tableViewProxy.$selectedArt
            .assign(to: \.selectedArt, on: viewModel)
            .store(in: &subscriptions)
    }
}
