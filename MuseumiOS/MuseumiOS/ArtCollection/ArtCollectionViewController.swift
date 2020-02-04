import UIKit
import Combine
import CombineCocoa
import TinyConstraints
import MuseumApp
import TimKit

class ArtCollectionViewController: UIViewController, AlertSubscriber {

    private var tokens: Set<AnyCancellable> = []

    private let presenter: ArtCollectionPresenter

    init(presenter: ArtCollectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        bindInput()
        bindOutput()
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
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
        return refreshControl
    }()

    private lazy var tableViewProxy = PortfolioTableViewProxy(tableView: tableView)
}

extension ArtCollectionViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.isAppeared = true
    }
}

private extension ArtCollectionViewController {

    func bindInput() {
        presenter.$model
            .receive(on: RunLoop.main)
            .map { $0.arts }
            .assign(to: \.arts, on: tableViewProxy)
            .store(in: &tokens)
    }

    func bindOutput() {

        //        viewModel.$isLoading
        //            .receive(on: RunLoop.main)
        //            .subscribe(refreshControl)

        //        viewModel.alertPublisher
        //            .receive(on: RunLoop.main)
        //            .subscribe(self)

        refreshControl.isRefreshingPublisher
            .assign(to: \.isRequestingRefresh, on: presenter)
            .store(in: &tokens)

        tableViewProxy.$selectedArt
            .assign(to: \.selectedArt, on: presenter)
            .store(in: &tokens)
    }
}
