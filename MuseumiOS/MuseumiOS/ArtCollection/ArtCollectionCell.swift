import UIKit
import SDWebImage
import TinyConstraints
import MuseumApp
import MuseumKit

class ArtCollectionCell: UITableViewCell {

    private lazy var thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        addSubview(thumbnail)
        thumbnail.edgesToSuperview(excluding: .left)
        thumbnail.widthToHeight(of: thumbnail)

        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true

        return thumbnail
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError() }

    var model: Art? = nil {
        didSet{
            textLabel?.text = model?.title
            detailTextLabel?.text = model?.artist
            thumbnail.sd_setImage(with: model?.imageURL)
        }
    }
}
