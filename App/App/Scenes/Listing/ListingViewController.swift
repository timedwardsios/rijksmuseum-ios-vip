
import UIKit
import SDWebImage

class ListingViewController: UIViewController{

    let interactor: ListingInteracting

    let imageView = UIImageView()

    init(interactor: ListingInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        interactor.loadArt()
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
