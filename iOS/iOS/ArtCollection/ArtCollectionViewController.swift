import App
import TinyConstraints
import UIKit
import Utils
import Combine
import Core

class ArtCollectionViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        return tableView
    }()

    private let tableViewProxy = TableViewProxy<ArtCollectionCell>()

    private let viewModel: ArtCollectionViewModel

    private let cancelBag = CancelBag()

    init(viewModel: ArtCollectionViewModel) { 
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
        bind()
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("Not implemented")
    }
}

extension ArtCollectionViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.didAppear.send()
    }
}

private extension ArtCollectionViewController {

    func setup() {
        tableViewProxy.tableView = tableView
        tableViewProxy.didSelectViewModel = { [weak self] in
            self?.viewModel.inputs.didSelectArt.send($0)
        }
    }

    func bind() {
        viewModel.outputs.arts
            .receive(on: RunLoop.main)
            .assign(to: \.viewModels, on: tableViewProxy)
            .store(in: cancelBag)
    }
}
