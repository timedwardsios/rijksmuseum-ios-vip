import UIKit
import TimKit
import SDWebImage

class ListingViewController: UIViewController, StoryboardLoadable {

    let interactor: ListingInteracting

    init(interactor: ListingInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadArt()
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

    func setImageURL(_ url: URL) {
//        self.imageView.sd_setImage(with: url)
    }
}
