import TimKit
import UIKit
import SDWebImage

class PortfolioCell: UICollectionViewCell, ViewModelSettable {

    @IBOutlet weak var imageView: UIImageView!

    func setViewModel(_ viewModel: PortfolioCellModel) {
        imageView.sd_setImage(with: viewModel.imageURL)
    }
}
