import UIKit
import Combine

public class UITableViewProxy <C: UITableViewCell & ViewModelSettable>:
NSObject, UITableViewDataSource, UITableViewDelegate {

    private var viewModels = [C.VM]()

    private let didSelectSubject = PassthroughSubject<C.VM, Never>()
    public lazy var didSelectPublisher: AnyPublisher<C.VM, Never> = didSelectSubject.eraseToAnyPublisher()

    private let tableView: UITableView
    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForItemAt(indexPath)
    }

    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModels[optionalAt: indexPath.row] {
            didSelectSubject.send(viewModel)
        }
    }
}

private extension UITableViewProxy {
    func cellForItemAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: C.reuseIdentifier,
                                                     for: indexPath) as? C,
            let viewModel = viewModels[optionalAt: indexPath.row] else {
                return UITableViewCell()
        }

        cell.setViewModel(viewModel)

        return cell
    }
}

extension UITableViewProxy: SimpleSubscriber {
    public func recieve(_ input: [C.VM]) {
        viewModels = input
        tableView.reloadData()
    }
}
