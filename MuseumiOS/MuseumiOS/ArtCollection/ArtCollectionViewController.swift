import RxSwift
import RxCocoa
import MuseumApp
import TinyConstraints
import UIKit
import Utils

class ArtCollectionViewController: UIViewController {
    private let viewModel: ArtCollectionViewModel

    private let disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.refreshControl = refreshControl
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(refreshControlDidChangeValue),
            for: .valueChanged
        )
        return refreshControl
    }()

    private lazy var dataSource = ArtCollectionDataSource(tableView: tableView)

    init(viewModel: ArtCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("Not implemented")
    }
}

extension ArtCollectionViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.didAppear.accept(())
    }
}

@objc extension ArtCollectionViewController {
    func refreshControlDidChangeValue() {
        viewModel.inputs.didTriggerRefresh.accept(())
    }
}

private extension ArtCollectionViewController {
    func bind() {

        viewModel.outputs.arts
            .asDriver()
            .drive(onNext: { self.dataSource.arts = $0 })
            .disposed(by: disposeBag)


        viewModel.outputs.isRefreshing
            .asDriver()
            .drive(refreshControl.rx.isRefreshingAnimated)
            .disposed(by: disposeBag)


        dataSource.didSelectArt
            .asSignal()
            .emit(to: viewModel.inputs.didSelectArt)
            .disposed(by: disposeBag)
    }
}
