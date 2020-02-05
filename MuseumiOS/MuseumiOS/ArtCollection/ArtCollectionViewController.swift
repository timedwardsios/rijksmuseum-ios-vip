import UIKit
import Combine
import CombineCocoa
import TinyConstraints
import MuseumApp
import TimKit

class ArtCollectionViewController: UIViewController {

    private var tokens: Set<AnyCancellable> = []

    private let interactor: ArtCollectionInteractor

    init(interactor: ArtCollectionInteractor) {
        self.interactor = interactor
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
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
        return refreshControl
    }()

    private lazy var tableViewProxy = PortfolioTableViewProxy(tableView: tableView)
}

extension ArtCollectionViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.isAppeared = true
    }
}

private extension ArtCollectionViewController {

    func bind() {
        interactor.$arts
            .receive(on: RunLoop.main)
            .assign(to: \.arts, on: tableViewProxy)
            .store(in: &tokens)

        interactor.$isRequestingRefresh
            .receive(on: RunLoop.main)
            .print()
            .subscribe(refreshControl)







//        refreshControl.isRefreshingPublisher
//            .assign(to: \.isRequestingRefresh, on: interactor)
//            .store(in: &tokens)

        tableViewProxy.$selectedArt
            .assign(to: \.selectedArt, on: interactor)
            .store(in: &tokens)
    }
}
