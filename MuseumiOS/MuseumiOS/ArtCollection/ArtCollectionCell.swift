import MuseumApp
import MuseumDomain
import SDWebImage
import TinyConstraints
import UIKit

class ArtCollectionCell: UITableViewCell {
    struct Model {
        let title: String
        let artist: String
        let imageURL: URL
    }

    var model: Model? {
        didSet {
            textLabel?.text = model?.title
            detailTextLabel?.text = model?.artist
            thumbnail.sd_setImage(with: model?.imageURL)
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
