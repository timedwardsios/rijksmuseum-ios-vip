import UIKit
import Combine
import MuseumApp
import MuseumKit

class PortfolioTableViewProxy: NSObject {

    private static let rowHeight = CGFloat(66)

    var arts = [Art]() {
        didSet{
            tableView.reloadData()
        }
    }

    @Published var selectedArt: Art? = nil

    private let tableView: UITableView
    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.register(ArtCollectionCell.self, forCellReuseIdentifier: ArtCollectionCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension PortfolioTableViewProxy: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Self.rowHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtCollectionCell.reuseIdentifier,
                                                     for: indexPath) as? ArtCollectionCell,
            let art = arts[optionalAt: indexPath.row] else {
                return UITableViewCell()
        }

        cell.model = art

        return cell
    }
}

extension PortfolioTableViewProxy: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let art = arts[optionalAt: indexPath.row] {
            selectedArt = art
        }
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.alpha = 0.5
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.alpha = 1
    }
}
