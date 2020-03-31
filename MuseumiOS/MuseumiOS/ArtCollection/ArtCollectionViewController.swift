import RxSwift
import RxCocoa
import MuseumApp
import TinyConstraints
import UIKit
import Utils

class ArtCollectionViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        return tableView
    }()

    private lazy var dataSource = ArtCollectionDataSource(tableView: tableView)

    private let viewModel: ArtCollectionViewModel

    private let disposeBag = DisposeBag()

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

private extension ArtCollectionViewController {
    func bind() {

        viewModel.outputs.arts
            .asDriver()
            .drive(onNext: { self.dataSource.arts = $0 })
            .disposed(by: disposeBag)

        dataSource.didSelectArt
            .asSignal()
            .emit(to: viewModel.inputs.didSelectArt)
            .disposed(by: disposeBag)
    }
}
