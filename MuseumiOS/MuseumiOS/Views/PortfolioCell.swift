import TimKit
import UIKit
import SDWebImage

class PortfolioCell: UITableViewCell, ViewModelSettable {

    @IBOutlet weak var mainImageView: UIImageView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    func setViewModel(_ viewModel: PortfolioCellModel) {
        mainImageView.sd_setImage(with: viewModel.imageURL)
    }
}
