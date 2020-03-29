import Combine
import MuseumApp
import MuseumDomain
import UIKit

class ArtCollectionDataSource: NSObject {

    private static let rowHeight = CGFloat(66)

    var arts = [Art]() {
        didSet {
            tableView.reloadData()
        }
    }

    @Published var selectedArt: Art?

    private let tableView: UITableView

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.register(ArtCollectionCell.self, forCellReuseIdentifier: ArtCollectionCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ArtCollectionDataSource: UITableViewDataSource {

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        Self.rowHeight
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        arts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ArtCollectionCell.reuseIdentifier,
                for: indexPath
            ) as? ArtCollectionCell,
            let art = arts[optionalAt: indexPath.row] else {
            return UITableViewCell()
        }

        cell.model = .init(title: art.title, artist: art.artist, imageURL: art.imageURL)

        return cell
    }
}

extension ArtCollectionDataSource: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
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
