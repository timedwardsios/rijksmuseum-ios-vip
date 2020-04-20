import App
import Core
import SDWebImage
import TinyConstraints
import UIKit
import Utils

class ArtCollectionCell: UITableViewCell, HasViewModel {

    var viewModel: Art? {
        didSet {
            textLabel?.text = viewModel?.title
            detailTextLabel?.text = viewModel?.artist
            thumbnail.sd_setImage(with: viewModel?.imageURL)
        }
    }

    private lazy var thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        addSubview(thumbnail)
        thumbnail.edgesToSuperview(excluding: .left)
        thumbnail.widthToHeight(of: thumbnail)
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        return thumbnail
    }()

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("Not implemented")
    }
}
