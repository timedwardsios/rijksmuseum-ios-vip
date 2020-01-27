import UIKit
import TimKit
import SDWebImage

class DetailsViewController: UIViewController {

    let interactor: DetailsInteracting

    required init?(coder: NSCoder, interactor: DetailsInteracting) {
        self.interactor = interactor
        super.init(coder: coder)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadArt()
    }
}

extension DetailsViewController: DetailsDisplaying {
    func displayImageURL(_ url: URL) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.sd_setImage(with: url)
        }
    }
}
