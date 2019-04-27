
import UIKit
import SDWebImage

class ListingViewController: UIViewController{

    var interactor: ListingInteracting?

    private let imageView = UIImageView()

    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        interactor?.loadArt()
    }
}

private extension ListingViewController {
    func setupSubviews(){
        view.backgroundColor = UIColor(hex: "343537")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.edges(to: view)
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
