import TimKit
import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell, ItemConfigurable {

    @IBOutlet weak var imageView: UIImageView!

    func configure(with item: URL) {
        imageView?.sd_setImage(with: item, completed: nil)
    }
}
