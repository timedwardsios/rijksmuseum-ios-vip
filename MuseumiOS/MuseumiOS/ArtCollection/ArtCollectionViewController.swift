import UIKit
import Combine
import TinyConstraints
import MuseumApp
import Utils

class ArtCollectionViewController: UIViewController {

    private let viewModel: ArtCollectionViewModel

    private var subscriptions: Set<AnyCancellable> = []

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
        refreshControl.addTarget(self, action: #selector(refreshControlDidChangeValue), for: .valueChanged)
        return refreshControl
    }()

    private lazy var dataSource = ArtCollectionDataSource(tableView: tableView)
}

extension ArtCollectionViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.isAppeared = true
    }
}

@objc extension ArtCollectionViewController {
    func refreshControlDidChangeValue() {
        viewModel.isRequestingRefresh = refreshControl.isRefreshing
    }
}

private extension ArtCollectionViewController {

    func bind() {
        viewModel.$arts
            .receive(on: RunLoop.main)
            .assign(to: \.arts, on: dataSource)
            .store(in: &subscriptions)

        viewModel.$isRequestingRefresh
            .receive(on: RunLoop.main)
            .subscribe(refreshControl)

        dataSource.$selectedArt
            .assign(to: \.selectedArt, on: viewModel)
            .store(in: &subscriptions)
    }
}
