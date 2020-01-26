import UIKit
import SDWebImage

class PortfolioImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    func setImageURL(_ url: URL?) {
        imageView?.sd_cancelCurrentImageLoad()
        imageView?.sd_setImage(with: url, completed: nil)
    }
}
