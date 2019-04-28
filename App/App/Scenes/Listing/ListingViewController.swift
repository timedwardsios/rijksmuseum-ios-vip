
import UIKit
import Utils
import SDWebImage

class ListingViewController: UIViewController, StoryboardLoadable {

    var interactor: ListingInteracting?

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad(){
        super.viewDidLoad()
        interactor?.loadArt()
    }
}

extension ListingViewController: ListingDisplaying {
    func displayImageURL(_ url: URL) {
        DispatchQueue.main.async { [weak self] in
            self?.setImageURL(url)
        }
    }
}

private extension ListingViewController {

    func setImageURL(_ url:URL) {
        self.imageView.sd_setImage(with: url)
    }
}
