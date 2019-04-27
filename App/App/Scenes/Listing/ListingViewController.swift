
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
        DispatchQueue.main.async {
            self.imageView.sd_setImage(with: url,
                                  completed: nil)
        }
    }
}
